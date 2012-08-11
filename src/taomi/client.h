#ifndef CLIENT_H
#define CLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QUdpSocket>

class Client : public QObject
{
    Q_OBJECT
public:
    explicit Client(QObject *parent = 0);
    ~Client();

signals:
    void sendOrderComplete();

public slots:
    void sendOrder();
    void sendRegistration();
    void startSync();

private slots:
    void sendData();
    void getData();
    void connectionClosedByServer();
    void error();

public:
    quint16 getSeatNO();

private:
    void connectToServer(const QString & serverIP);
    void connectToServer(const QHostAddress & address);
    void closeConnection();

    QTcpSocket tcpSocket;
    QUdpSocket udpSocket;
    quint16 nextBlockSize;
    QByteArray *block;
};

#endif // CLIENT_H
