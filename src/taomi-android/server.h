#ifndef SERVER_H
#define SERVER_H

#include <QTcpServer>

class Server : public QTcpServer
{
    Q_OBJECT

public:
    Server(QObject *parent = 0);

signals:
    void refreshUi();
    void paied(quint32 orderNO);

private slots:
    void sendRefreshUiSignal();
    void sendPaiedSignal(quint32 orderNO);

private:
    void incomingConnection(int socketId);
};

#endif // SERVER_H
