#ifndef ORDERMANAGER_H
#define ORDERMANAGER_H

#include <QObject>
#include <QTcpSocket>

#include "client.h"

class OrderManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(quint32 orderNO READ getOrderNO WRITE setOrderNO NOTIFY orderNOChanged)
    Q_PROPERTY(quint16 suborderNO READ getSuborderNO WRITE setSuborderNO NOTIFY suborderNOChanged)
public:
    explicit OrderManager(QObject *parent = 0);
    ~OrderManager();

    void updateOrderNO();

    quint32 getOrderNO() const;
    void setOrderNO(const quint32 &s);
    quint16 getSuborderNO() const;
    void setSuborderNO(const quint16 &s);

signals:
    void orderNOChanged();
    void suborderNOChanged();
    void send();

public slots:
    void sendOrder();
    void payOrder(quint32 orderNO);

private:
    quint32 mOrderNO;
    quint16 mSuborderNO;
};

#endif // ORDERMANAGER_H
