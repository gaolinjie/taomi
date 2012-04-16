#include <QtGui/QApplication>
#include <QtDeclarative/QDeclarativeView>
#include <QtDeclarative/QDeclarativeEngine>
#include <QtDeclarative/QDeclarativeContext>
#include <iostream>
#include <QtSql>
#include <QDebug>

#include "server.h"
#include "client.h"
#include "ordermanager.h"
#include "devicemanager.h"

int main(int argc, char *argv[])
{ 
    QApplication::setGraphicsSystem("raster");
    QApplication a(argc, argv);

    QTextCodec::setCodecForTr(QTextCodec::codecForLocale());

    QString privatePathQt(QApplication::applicationDirPath());
    QString path(privatePathQt);
    path = QDir::toNativeSeparators(path);

    Server server;
    if (!server.listen(QHostAddress::Any, 6177)) {
        std::cerr << "Failed to bind to port" << std::endl;
        return 1;
    }

    QDeclarativeView view;
    view.engine()->setOfflineStoragePath(path);
    QObject::connect((QObject*)view.engine(), SIGNAL(quit()), &a, SLOT(quit()));

    view.setSource(QUrl("qrc:/qml/main.qml"));
    view.show();

    QString md5;
    QString dbname="DemoDB";
    QByteArray ba;
    ba = QCryptographicHash::hash (dbname.toAscii(), QCryptographicHash::Md5);
    md5.append(ba.toHex());
    md5.append(".sqlite");

    path.append(QDir::separator()).append("Databases");
    path.append(QDir::separator()).append(md5);
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(path);
    if (!db.open()) {
        std::cerr << "Cannot open database" << std::endl;
        return 1;
    }

    OrderManager orderManager;
    view.rootContext()->setContextProperty("server", &server);
    view.rootContext()->setContextProperty("orderManager", &orderManager);

    Client client;
    QObject::connect(&orderManager, SIGNAL(send()), &client, SLOT(sendOrder()));
    QObject::connect(&server, SIGNAL(paied(quint32)), &orderManager, SLOT(payOrder(quint32)));

    DeviceManager deviceManager;
    QObject::connect(&deviceManager, SIGNAL(registerSignal()), &client, SLOT(sendRegistration()));
    view.rootContext()->setContextProperty("deviceManager", &deviceManager);
    deviceManager.registerDevice();
/*
    QSqlQuery query;
    QSqlQuery query2;
    QSqlQuery query3;
    query.exec("SELECT * FROM unsentModel");

    quint32 orderNO = 0;
    QString name = "";
    QString image = "";
    float price = 0;
    quint16 num = 0;
    while (query.next()) {
        if (orderNO == 0) {
            orderNO = query.value(0).toUInt();
        }
        name = query.value(1).toString();
        image = query.value(2).toString();
        price = query.value(3).toFloat();
        num = query.value(4).toUInt();


        query2.exec("CREATE TABLE IF NOT EXISTS sentModel(orderNO INTEGER key, name TEXT, image TEXT, price REAL, num INTEGER, sent INTEGER)");
        query2.prepare("SELECT * FROM sentModel WHERE name = ?");
        query2.addBindValue(name);
        query2.exec();

        if (query2.next()) {
            qDebug() << "dasf";
            quint16 n = query2.value(4).toUInt();
            query3.prepare("UPDATE sentModel SET num = ? WHERE name = ?" );
            query3.addBindValue(++n);
            query3.addBindValue(name);
            query3.exec();
        }
        else {
            qDebug() << "here!!!";
            query3.prepare("INSERT INTO sentModel(orderNO, name, image, price, num, sent) VALUES (?, ?, ?, ?, ?, ?)");
            query3.addBindValue(orderNO);
            query3.addBindValue(name);
            query3.addBindValue(image);
            query3.addBindValue(price);
            query3.addBindValue(num);
            query3.addBindValue(1);
            query3.exec();

            qDebug() << "here!!!";
        }
    }*/

    return a.exec();
}
