#ifndef ORDERMANAGER_H
#define ORDERMANAGER_H

#include <QObject>
#include <QTcpSocket>

#include "client.h"

class OrderManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(quint32 orderNO READ getOrderNO WRITE setOrderNO NOTIFY orderNOChanged)
    Q_PROPERTY(quint16 seatNO READ getSeatNO WRITE setSeatNO NOTIFY seatNOChanged)
public:
    explicit OrderManager(QObject *parent = 0);
    ~OrderManager();

    void updateOrderNO();

    quint32 getOrderNO() const;
    void setOrderNO(const quint32 &s);

signals:
    void orderNOChanged();
    void seatNOChanged();
    void send();
    void clearShopcar();

public slots:
    void sendOrder();
    void payOrder(quint32 orderNO);
    bool isHaveNewOrder();
    void setSeatNO(const quint16 &s);
    qint16 getSeatNO() const;

private:
    quint32 mOrderNO;
    quint16 mSeatNO;
};

#endif // ORDERMANAGER_H
