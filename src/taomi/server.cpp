#include "server.h"
#include "clientsocket.h"

Server::Server(QObject *parent)
    : QTcpServer(parent)
{

}

void Server::incomingConnection(int socketId)
{
    ClientSocket *socket = new ClientSocket(this);
    socket->setSocketDescriptor(socketId);
    connect(socket, SIGNAL(dbChanged()), this, SLOT(sendRefreshUiSignal()));
    connect(socket, SIGNAL(paied(quint32)), this, SLOT(sendPaiedSignal(quint32)));
    connect(socket, SIGNAL(readySync()), this, SLOT(sendSyncSignal()));
}

void Server::sendRefreshUiSignal()
{
    emit refreshUi();
}

void Server::sendPaiedSignal(quint32 orderNO)
{
    emit paied(orderNO);
    qDebug() << "paied in server";
}

void Server::sendSyncSignal()
{
    emit sync();
}
