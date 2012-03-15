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

    return a.exec();
}
