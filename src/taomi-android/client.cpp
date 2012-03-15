#include "client.h"

#include <QtNetwork>
#include <QDebug>

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
    block = new QByteArray();
    QDataStream out(block, QIODevice::WriteOnly);
    out.setVersion(QDataStream::Qt_4_7);
    out << quint16(0) << quint8('S') <<QString("120212002") << QString("13") << QString("2012-02-12") << QString("12:55") << QString("10") << QString("111");


    out.device()->seek(0);
    out << quint16(block->size() - sizeof(quint16));

    connectToServer();
}

void Client::connectToServer()
{
    tcpSocket.connectToHost("192.168.1.104", 6178);
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
