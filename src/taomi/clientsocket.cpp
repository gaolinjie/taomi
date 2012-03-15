#include <QtNetwork>
#include <QtSql>
#include <QDebug>

#include "clientsocket.h"

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

    if (nextBlockSize == 0) {
        if (bytesAvailable() < sizeof(quint16))
            return;
        in >> nextBlockSize;
    }

    if (bytesAvailable() < nextBlockSize)
        return;

    quint8 requestType;
    quint32 orderNO;

    in >> requestType;
    if (requestType == 'S') {
        in >> orderNO;

        emit paied(orderNO);
    }

    close();
}
