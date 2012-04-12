#include "ordermanager.h"
#include "devicemanager.h"

#include <QtSql>
#include <QDebug>
#include <QDateTime>
#include <QtNetwork>

#define TAG "[OrderManager]"

// 设备序号：PAD接入局域网，向服务器发送注册信号，获取唯一设备序号
#define DEVICE_NO 10100000

OrderManager::OrderManager(QObject *parent) :
    QObject(parent)
{
    updateOrderNO();
}

OrderManager::~OrderManager()
{
}

void OrderManager::updateOrderNO()
{
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS lastSentOrder(orderNO INTEGER key, suborderNO INTEGER)");
    query.exec("SELECT * FROM lastSentOrder");
    quint32 lastSentOrderNO = 0;
    quint16 lastSentSuborderNO = 0;
    while (query.next())
    {
        lastSentOrderNO = query.value(0).toUInt();
        lastSentSuborderNO = query.value(1).toUInt();
        if (lastSentOrderNO == 0 || lastSentSuborderNO == 0)
        {
            qDebug() << TAG << "lastSentOrder 表中数据有错误" << __FILE__ << __LINE__ ;

        }
    }

    query.exec("CREATE TABLE IF NOT EXISTS shopcarOrder(orderNO INTEGER key, suborderNO INTEGER, name TEXT, image TEXT, price REAL, num INTEGER)");
    query.exec("SELECT * FROM shopcarOrder");
    quint32 shopcarOrderNO = 0;
    quint16 shopcarSuborderNO = 0;
    while (query.next())
    {
        shopcarOrderNO = query.value(0).toUInt();
        shopcarSuborderNO = query.value(1).toUInt();
        if (shopcarOrderNO == 0 || shopcarSuborderNO == 0)
        {
            qDebug() << TAG << "shopcarTable 中数据有错误" << __FILE__ << __LINE__;
        }
    }

    if (lastSentOrderNO == 0 && shopcarOrderNO == 0)
    {
        // 生成新的orderNO
        quint32  orderNO;
        orderNO = DEVICE_NO + 1;
        mOrderNO = orderNO;
        mSuborderNO = 1;
    }
    else if (lastSentOrderNO != 0 && shopcarOrderNO == 0)
    {
        // 上一个 orderNO + 1
        quint32 nOrderNO = lastSentOrderNO;
        nOrderNO++;
        mOrderNO = nOrderNO;
        mSuborderNO = 1;
    }
    else if (lastSentOrderNO != 0 && shopcarOrderNO != 0)
    {
        // 取 shopcarTable 中的 orderNO
        mOrderNO = shopcarOrderNO;
        if (lastSentOrderNO == shopcarOrderNO) {
            quint16 nSuborderNO =  lastSentSuborderNO;
            nSuborderNO++;
            mSuborderNO = nSuborderNO;
        }
        else {
            mSuborderNO = shopcarSuborderNO;
        }
    }
    else if (lastSentOrderNO == 0 && shopcarOrderNO != 0)
    {
        // 取 shopcarTable 中的 orderNO 和 subOrderNO
        mOrderNO = shopcarOrderNO;
        mSuborderNO = shopcarSuborderNO;
    }
    qDebug() << TAG << QString("%1").arg(mOrderNO) << QString("%1").arg(mSuborderNO) << __FILE__ << __LINE__;
}

quint32 OrderManager::getOrderNO() const
{
    return mOrderNO;
}

void OrderManager::setOrderNO(const quint32 &s)
{
    mOrderNO = s;
}

quint16 OrderManager::getSuborderNO() const
{
    return mSuborderNO;
}

void OrderManager::setSuborderNO(const quint16 &s)
{
    mSuborderNO = s;
}

void OrderManager::sendOrder()
{
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS shopcarOrder(orderNO INTEGER key, suborderNO INTEGER, name TEXT, image TEXT, price REAL, num INTEGER)");
    query.exec("SELECT * FROM shopcarOrder");
    quint32 shopcarOrderNO = 0;
    quint16 shopcarSuborderNO = 0;
    while (query.next())
    {
        shopcarOrderNO = query.value(0).toUInt();
        shopcarSuborderNO = query.value(1).toUInt();
    }

    query.exec("CREATE TABLE IF NOT EXISTS lastSentOrder(orderNO INTEGER key, suborderNO INTEGER)");
    query.exec("DELETE FROM lastSentOrder");
    query.prepare("INSERT INTO lastSentOrder(orderNO, suborderNO) VALUES (?, ?)");
    query.addBindValue(shopcarOrderNO);
    query.addBindValue(shopcarSuborderNO);
    query.exec();

    emit send();
    qDebug() << TAG << "send order" << __FILE__ << __LINE__;
}

void OrderManager::payOrder(quint32 orderNO)
{
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS shopcarOrder(orderNO INTEGER key, suborderNO INTEGER, name TEXT, image TEXT, price REAL, num INTEGER)");
    query.exec("DROP TABLE shopcarOrder");
    mOrderNO = orderNO + 1;
}

bool OrderManager::isHaveNewOrder()
{
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS lastSentOrder(orderNO INTEGER key, suborderNO INTEGER)");
    query.exec("SELECT * FROM lastSentOrder");
    quint32 lastSentOrderNO = 0;
    quint16 lastSentSuborderNO = 0;
    if (query.next())
    {
        lastSentOrderNO = query.value(0).toUInt();
        lastSentSuborderNO = query.value(1).toUInt();
    }

    query.exec("CREATE TABLE IF NOT EXISTS shopcarOrder(orderNO INTEGER key, suborderNO INTEGER, name TEXT, image TEXT, price REAL, num INTEGER)");
    query.exec("SELECT * FROM shopcarOrder");
    quint32 shopcarOrderNO = 0;
    quint16 shopcarSuborderNO = 0;
    while (query.next())
    {
        shopcarOrderNO = query.value(0).toUInt();
        shopcarSuborderNO = query.value(1).toUInt();
    }

    if (shopcarOrderNO == 0 || (shopcarOrderNO != 0 && lastSentSuborderNO == shopcarSuborderNO))
    {
        return false;
    }
    else
    {
        return true;
    }
}


