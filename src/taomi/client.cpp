#include "client.h"

#include <QtNetwork>
#include <QDebug>
#include <QtSql>

#define TAG "[CLIENT]"

Client::Client(QObject *parent) :
    QObject(parent)
{
    connect(&tcpSocket, SIGNAL(connected()), this, SLOT(sendData()));
    connect(&tcpSocket, SIGNAL(disconnected()),
            this, SLOT(connectionClosedByServer()));
    connect(&tcpSocket, SIGNAL(readyRead()),
            this, SLOT(getData()));
    connect(&tcpSocket, SIGNAL(error(QAbstractSocket::SocketError)),
            this, SLOT(error()));
}

Client::~Client()
{
    delete block;
    block = 0;
}

void Client::sendOrder()
{
    quint16 seatNO = 1; // 暂时定义

    block = new QByteArray();
    QDataStream out(block, QIODevice::WriteOnly);
    out.setVersion(QDataStream::Qt_4_7);
    out << quint16(0) << quint8('C');

    QSqlQuery query;
    query.exec("select max(suborderNO) from shopcarOrder");
    quint32 shopcarOrderNO = 0;
    quint16 shopcarSuborderNO = 0;
    while (query.next()) {
        shopcarSuborderNO = query.value(0).toUInt();
    }

    query.prepare("SELECT * FROM shopcarOrder WHERE suborderNO = ?");
    query.addBindValue(shopcarSuborderNO);
    query.exec();
    QString name = "";
    float price = 0;
    quint16 num = 0;
    while (query.next()) {
        if (shopcarOrderNO == 0)
        {
            shopcarOrderNO = query.value(0).toUInt();
            out << quint32(shopcarOrderNO)  << quint16(shopcarSuborderNO)  << quint16(seatNO);
            qDebug() << QString("%1").arg(shopcarOrderNO) << QString("%1").arg(seatNO);
        }
        name = query.value(2).toString();
        price = query.value(4).toFloat();
        num = query.value(5).toUInt();
        out << name  << price << num;
        qDebug() << name;
    }
    QString endFlag = "FFFF";
    out << endFlag;

    out.device()->seek(0);
    out << quint16(block->size() - sizeof(quint16));

    connectToServer();
}

void Client::connectToServer()
{
    tcpSocket.connectToHost(QHostAddress::LocalHost, 6178);
    nextBlockSize = 0;
}

void Client::sendData()
{
    tcpSocket.write(*block);

    delete block;
    block = 0;
}

void Client::getData()
{

}


void Client::connectionClosedByServer()
{
    if (nextBlockSize != 0xFFFF)
        ;
    closeConnection();
}

void Client::error()
{
    closeConnection();
}

void Client::closeConnection()
{
    tcpSocket.close();
}
