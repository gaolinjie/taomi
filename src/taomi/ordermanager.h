#ifndef ORDERMANAGER_H
#define ORDERMANAGER_H

#include <QObject>
#include <QTcpSocket>

#include "client.h"

class OrderManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(quint32 orderNO READ getOrderNO WRITE setOrderNO NOTIFY orderNOChanged)
public:
    explicit OrderManager(QObject *parent = 0);
    ~OrderManager();

    void updateOrderNO();

    quint32 getOrderNO() const;
    void setOrderNO(const quint32 &s);

signals:
    void orderNOChanged();
    void send();

public slots:
    void sendOrder();
    void payOrder(quint32 orderNO);
    bool isHaveNewOrder();

private:
    quint32 mOrderNO;
};

#endif // ORDERMANAGER_H
