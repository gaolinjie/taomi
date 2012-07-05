#include <QtGui/QApplication>
#include <QtDeclarative/QDeclarativeView>
#include <QtDeclarative/QDeclarativeEngine>
#include <QtDeclarative/QDeclarativeContext>
//#include <iostream> // 会产生错误:预料中的符号 `;'
#include <QtSql>
#include <QDebug>

#include "server.h"
#include "client.h"
#include "ordermanager.h"
#include "devicemanager.h"
#include "refreshmanager.h"

int main(int argc, char *argv[])
{ 
    QApplication::setGraphicsSystem("raster");
    QApplication a(argc, argv);

    QTextCodec::setCodecForTr(QTextCodec::codecForLocale());

    QString privatePathQt(QApplication::applicationDirPath());
    QString path(privatePathQt);
    path = QDir::toNativeSeparators(path);
    qDebug() << path;

    Server server;
    if (!server.listen(QHostAddress::Any, 6177)) {
        //std::cerr << "Failed to bind to port" << std::endl;
        qDebug() << "Failed to bind to port";
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
        //std::cerr << "Cannot open database" << std::endl;
        qDebug() << "Cannot open database";
        return 1;
    }

    RefreshManager refreshManager;
    view.rootContext()->setContextProperty("refreshManager", &refreshManager);

    OrderManager orderManager;
    view.rootContext()->setContextProperty("server", &server);
    view.rootContext()->setContextProperty("orderManager", &orderManager);

    Client client;
    QObject::connect(&orderManager, SIGNAL(send()), &client, SLOT(sendOrder()));
    QObject::connect(&server, SIGNAL(paied(quint32)), &orderManager, SLOT(payOrder(quint32)));
    view.rootContext()->setContextProperty("client", &client);

    DeviceManager deviceManager;
    QObject::connect(&deviceManager, SIGNAL(registerSignal()), &client, SLOT(sendRegistration()));
    view.rootContext()->setContextProperty("deviceManager", &deviceManager);
    deviceManager.registerDevice();

    return a.exec();
}
