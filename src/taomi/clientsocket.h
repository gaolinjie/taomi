#ifndef CLIENTSOCKET_H
#define CLIENTSOCKET_H

#include <QTcpSocket>

class ClientSocket : public QTcpSocket
{
    Q_OBJECT

public:
    ClientSocket(QObject *parent = 0);

signals:
    void dbChanged();
    void paied(quint32 orderNO);
    void requestSync();
    void synced();

private slots:
    void readClient();

private:
    quint16 nextBlockSize;
    qint16 mCount;
};

#endif // CLIENTSOCKET_H
