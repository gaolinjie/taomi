#include "client.h"
#include "devicemanager.h"

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
    out << quint16(0) << quint8('O');

    QSqlQuery query;
    query.exec("SELECT * FROM unsentModel");

    quint32 orderNO = 0;
    QString name = "";
    QString image = "";
    float price = 0;
    quint16 num = 0;
    while (query.next()) {
        if (orderNO == 0) {
            orderNO = query.value(0).toUInt();
            out << quint32(orderNO) << quint16(seatNO) << DeviceManager::getDeviceMac();
        }
        name = query.value(1).toString();
        image = query.value(2).toString();
        price = query.value(3).toFloat();
        num = query.value(4).toUInt();
        out << 0x1111 << name  << price << num;
    }
    query.exec("DELETE FROM unsentModel");
    out << 0xFFFF;

    out.device()->seek(0);
    out << quint16(block->size() - sizeof(quint16));

    QString serverIP = DeviceManager::getServerIP();
    connectToServer(serverIP);
    emit sendOrderComplete();
}

void Client::sendRegistration()
{
    QByteArray datagram;
    QDataStream out(&datagram, QIODevice::WriteOnly);
    out.setVersion(QDataStream::Qt_4_7);
    out << quint16(0) << quint8('R');

    out << DeviceManager::getDeviceMac() << DeviceManager::getDeviceIP();
    out << 0xFFFF;

    //out.device()->seek(0);
    //out << quint16(block->size() - sizeof(quint16));

    udpSocket.writeDatagram(datagram, QHostAddress::Broadcast, 6178);
}

void Client::connectToServer(const QString & serverIP)
{
    tcpSocket.connectToHost(serverIP, 6178);
    nextBlockSize = 0;
}

void Client::connectToServer(const QHostAddress & address)
{
    tcpSocket.connectToHost(address, 6178);
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
    {};
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
