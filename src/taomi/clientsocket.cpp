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
        qDebug() << "dsafasd" << serverIP;

        DeviceManager::setDeviceNO(deviceNO);
        DeviceManager::setServerIP(serverIP);
    }
    else if (requestType == 'X')
    {
        emit requestSync();

        QTime dieTime = QTime::currentTime().addMSecs(5000);
        while( QTime::currentTime() < dieTime )
        QCoreApplication::processEvents(QEventLoop::AllEvents, 100);

        quint16 cnum=0;
        quint16 inum=0;
        quint16 scnum=0;
        quint16 snum=0;
        in >> scnum >> snum>> cnum >> inum;

        qDebug() << "scnum" << scnum << "snum" << snum << "cnum" << cnum << "inum" << inum;

        QSqlQuery query;
        if (scnum > 0) {
            query.exec("DROP TABLE seatTypeDB");
            query.exec("CREATE TABLE IF NOT EXISTS seatTypeDB(scid TEXT key, name TEXT, active INTEGER)");
            QString scid = "";
            QString scname = "";
            quint16 active = 1;
            while (scnum > 0) {
                in >> scid >> scname;
                query.prepare("INSERT INTO seatTypeDB(scid, name, active) VALUES (?, ?, ?)");
                query.addBindValue(scid);
                query.addBindValue(scname);
                query.addBindValue(active);
                query.exec();
                scnum--;
                if (active == 1) {
                    active = 0;
                }
            }
        }

        if (snum > 0) {
            qDebug() << "scnumqqqqq";
            query.exec("DROP TABLE seatItemDB");
            query.exec("CREATE TABLE IF NOT EXISTS seatItemDB(sid TEXT key, scid TEXT, seat TEXT, type TEXT, capacity INTEGER, active INTEGER)");
            QString sid = "";
            QString scid = "";
            QString seat = "";
            QString scname = "";
            quint16 capacity = 0;
            quint16 active = 0;
            while (snum > 0) {
                qDebug() << "xxxxxxxx";
                in >> sid >> scid >> seat >> scname >> capacity;
                query.prepare("INSERT INTO seatItemDB(sid, scid, seat, type, capacity, active) VALUES (?, ?, ?, ?, ?, ?)");
                query.addBindValue(sid);
                query.addBindValue(scid);
                query.addBindValue(seat);
                query.addBindValue(scname);
                query.addBindValue(capacity);
                query.addBindValue(active);
                query.exec();
                snum--;
            }
        }

        if (cnum > 0) {
            query.exec("DROP TABLE menuDB");
            query.exec("CREATE TABLE IF NOT EXISTS menuDB(cid TEXT primary key, cursor INTEGER, title TEXT, image TEXT, style TEXT, slotQml TEXT, rectColor TEXT, hotColor TEXT)");
            QString cid = "";
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
                query.prepare("INSERT INTO menuDB(cid, cursor, title, image, style, slotQml, rectColor, hotColor) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
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
            query.exec("CREATE TABLE IF NOT EXISTS itemsDB(iid TEXT primary key, cid TEXT, tag TEXT, name TEXT, image TEXT, detail TEXT, price REAL, needPrint INTEGER, printer TEXT)");
            QString iid = 0;
            QString cid = 0;
            QString tag = "";
            QString name = "";
            QString image = "";
            QString detail = "";
            float price = 0;
            quint16 needPrint = 0;
            QString printer = "";
            while (inum > 0) {
                in >> iid >> cid >> tag >> name
                >> image >> detail >> price >> needPrint >> printer;
                image.prepend("file:///C:/taomi/");
                query.prepare("INSERT INTO itemsDB (iid, cid, tag, name, image, detail, price, needPrint, printer) VALUES (?,?,?,?,?,?,?,?,?)");
                query.addBindValue(iid);
                query.addBindValue(cid);
                query.addBindValue(tag);
                query.addBindValue(name);
                query.addBindValue(image);
                query.addBindValue(detail);
                query.addBindValue(price);
                query.addBindValue(needPrint);
                query.addBindValue(printer);
                query.exec();
                inum--;
            }
        }

        nextBlockSize = 0;

        if (mCount<0) {
            in >> mCount;
            qDebug() <<"cccccccc"<< mCount;
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

        QString mac = DeviceManager::getDeviceMac();
        QDataStream out(this);
        out.setVersion(QDataStream::Qt_4_7);
        out << quint16(0) << quint8('X') << mac;
        emit synced();
        qDebug() << "Synced";
    }

    close();
}
