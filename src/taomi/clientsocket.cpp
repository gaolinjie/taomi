#include <QtNetwork>
#include <QtSql>
#include <QDebug>
#include <QtDeclarative/QDeclarativeEngine>
#include <QtDeclarative/QDeclarativeComponent>

#include "clientsocket.h"
#include "devicemanager.h"

ClientSocket::ClientSocket(QObject *parent)
    : QTcpSocket(parent)
{
    connect(this, SIGNAL(readyRead()), this, SLOT(readClient()));
    connect(this, SIGNAL(disconnected()), this, SLOT(deleteLater()));

    nextBlockSize = 0;
    mCount = -1;
}

void ClientSocket::readClient()
{
    qDebug() << "cnum << inum";
    QDataStream in(this);
    in.setVersion(QDataStream::Qt_4_7);

    if (nextBlockSize == 0)
    {
        if (bytesAvailable() < sizeof(quint16))
            return;
        in >> nextBlockSize;
    }

    if (bytesAvailable() < nextBlockSize)
        return;

    quint8 requestType;


    in >> requestType;
    if (requestType == 'S')
    {
        quint32 orderNO;
        in >> orderNO;

        emit paied(orderNO);
    }
    else if (requestType == 'R')
    {
        quint32 deviceNO;
        QString serverIP;

        in >> deviceNO >> serverIP;

        DeviceManager::setDeviceNO(deviceNO);
        DeviceManager::setServerIP(serverIP);
    }
    else if (requestType == 'X')
    {
        quint16 cnum;
        quint16 inum;
        in >> cnum >> inum;

        QSqlQuery query;
        if (cnum > 0) {
            query.exec("DROP TABLE startModel");
            query.exec("CREATE TABLE IF NOT EXISTS startModel(cid INTEGER primary key, cursor INTEGER, title TEXT, image TEXT, style TEXT, slotQml TEXT, rectColor TEXT, hotColor TEXT)");
            quint16 cid = 0;
            quint16 cursor = 0;
            QString title = "";
            QString image = "";
            QString style = "";
            QString slotQml = "";
            QString rectColor = "";
            QString hotColor = "";
            while (cnum > 0) {
                in >> cid >> title >> image >> style
                >> slotQml >> rectColor >> hotColor;
                image.prepend("file:///C:/taomi/");
                query.prepare("INSERT INTO startModel(cid, cursor, title, image, style, slotQml, rectColor, hotColor) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
                query.addBindValue(cid);
                query.addBindValue(cursor);
                query.addBindValue(title);
                query.addBindValue(image);
                query.addBindValue(style);
                query.addBindValue(slotQml);
                query.addBindValue(rectColor);
                query.addBindValue(hotColor);
                query.exec();
                cnum--;
            }
        }

        if (inum > 0) {
            query.exec("DROP TABLE itemModel");
            query.exec("CREATE TABLE IF NOT EXISTS itemsData(iid INTEGER primary key, cid INTEGER, tag TEXT, name TEXT, image TEXT, detail TEXT, price REAL)");
            quint16 iid = 0;
            quint16 cid = 0;
            QString tag = "";
            QString name = "";
            QString image = "";
            QString detail = "";
            float price = 0;
            while (inum > 0) {
                in >> iid >> cid >> tag >> name
                >> image >> detail >> price;
                image.prepend("file:///C:/taomi/");
                query.prepare("INSERT INTO itemsData (iid, cid, tag, name, image, detail, price) VALUES (?,?,?,?,?,?,?)");
                query.addBindValue(iid);
                query.addBindValue(cid);
                query.addBindValue(tag);
                query.addBindValue(name);
                query.addBindValue(image);
                query.addBindValue(detail);
                query.addBindValue(price);
                query.exec();
                inum--;
            }
        }

        nextBlockSize = 0;

        if (mCount<0) {
            in >> mCount;
            qDebug() << mCount;
        }

        quint32 imageSize = 0;
        while(mCount>0) {
            if (imageSize == 0)
            {
                if (bytesAvailable() < sizeof(quint32))
                return;
                in >> imageSize;
            }

            do {
                waitForReadyRead(1000);
            } while (bytesAvailable() < imageSize);

            QString imageName;
            in >> imageName;
            QFile file("C:/taomi/" + imageName);
            if (!file.open(QIODevice::WriteOnly))
                return;

            QByteArray ba;
            in >> ba;
            file.write(ba);
            file.close();
            imageSize=0;
            mCount--;
        }
        emit readySync();
    }

    close();
}

void ClientSocket::loadSyncView()
{
    QDeclarativeEngine engine;
    QDeclarativeComponent component(&engine, QUrl("qrc:/qml/start.qml"));
    QObject *object = component.create();

    QVariant returnedValue;
    QVariant msg = "loadSyncView";
    QMetaObject::invokeMethod(object, "loadSyncView",
    Q_RETURN_ARG(QVariant, returnedValue),
    Q_ARG(QVariant, msg));

    qDebug() << "QML function returned:" << returnedValue.toString();
    delete object;
}
