#include <QtNetwork>
#include <QtSql>
#include <QDebug>

#include "clientsocket.h"
#include "devicemanager.h"

ClientSocket::ClientSocket(QObject *parent)
    : QTcpSocket(parent)
{
    connect(this, SIGNAL(readyRead()), this, SLOT(readClient()));
    connect(this, SIGNAL(disconnected()), this, SLOT(deleteLater()));

    nextBlockSize = 0;
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

        DeviceManager::setDeviceNO(deviceNO);
        DeviceManager::setServerIP(serverIP);
    }

    close();
}
