
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
    query.exec("CREATE TABLE IF NOT EXISTS lastSentModel(orderNO INTEGER key)");
    query.exec("SELECT * FROM lastSentModel");
    quint32 lastSentOrderNO = 0;
    if (query.next()) {
        lastSentOrderNO = query.value(0).toUInt();
        if (lastSentOrderNO == 0) {
            qDebug() << TAG << "lastSentModel 表中数据有错误" << __FILE__ << __LINE__ ;

        }
    }

    query.exec("CREATE TABLE IF NOT EXISTS sentModel(orderNO INTEGER key, name TEXT, image TEXT, price REAL, num INTEGER, sent INTEGER)");
    query.exec("SELECT * FROM sentModel");
    quint32 sentOrderNO = 0;
    if (query.next()) {
        sentOrderNO = query.value(0).toUInt();
        if (sentOrderNO == 0) {
            qDebug() << TAG << "sentModel 中数据有错误" << __FILE__ << __LINE__;
        }
    }

    query.exec("CREATE TABLE IF NOT EXISTS unsentModel(orderNO INTEGER key, name TEXT, image TEXT, price REAL, num INTEGER, sent INTEGER)");
    query.exec("SELECT * FROM unsentModel");
    quint32 unsentOrderNO = 0;
    if (query.next()) {
        unsentOrderNO = query.value(0).toUInt();
        if (unsentOrderNO == 0) {
            qDebug() << TAG << "unsentModel 中数据有错误" << __FILE__ << __LINE__;
        }
    }

    if (sentOrderNO == 0 && unsentOrderNO == 0) {
        if (lastSentOrderNO == 0) {
            // 生成新的orderNO
            quint32  orderNO;
            orderNO = DEVICE_NO + 1;
            mOrderNO = orderNO;
        }
        else {
            // 上一个 orderNO + 1
            quint32 nOrderNO = lastSentOrderNO;
            nOrderNO++;
            mOrderNO = nOrderNO;
        }
    }
    else {
        if (unsentOrderNO != 0) {
            mOrderNO = unsentOrderNO;
        }

        if (sentOrderNO != 0) {
            mOrderNO = sentOrderNO;
        }
    }
}

quint32 OrderManager::getOrderNO() const
{
    return mOrderNO;
}

void OrderManager::setOrderNO(const quint32 &s)
{
    mOrderNO = s;
}

void OrderManager::sendOrder()
{
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS unsentModel(orderNO INTEGER key, name TEXT, image TEXT, price REAL, num INTEGER, sent INTEGER)");
    query.exec("SELECT * FROM unsentModel");
    quint32 unsentOrderNO = 0;
    if (query.next()) {
        unsentOrderNO = query.value(0).toUInt();
    }

    query.exec("CREATE TABLE IF NOT EXISTS lastSentModel(orderNO INTEGER key)");
    query.exec("DELETE FROM lastSentModel");
    query.prepare("INSERT INTO lastSentModel(orderNO) VALUES (?)");
    query.addBindValue(unsentOrderNO);
    query.exec();

    emit send();
    qDebug() << TAG << "send order" << __FILE__ << __LINE__;
}

void OrderManager::payOrder(quint32 orderNO)
{
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS unsentModel(orderNO INTEGER key, name TEXT, image TEXT, price REAL, num INTEGER, sent INTEGER)");
    query.exec("DROP TABLE unsentModel");
    query.exec("CREATE TABLE IF NOT EXISTS sentModel(orderNO INTEGER key, name TEXT, image TEXT, price REAL, num INTEGER, sent INTEGER)");
    query.exec("DROP TABLE sentModel");
    mOrderNO = orderNO + 1;
    emit clearShopcar();
}

bool OrderManager::isHaveNewOrder()
{
    QSqlQuery query;

    query.exec("CREATE TABLE IF NOT EXISTS unsentModel(orderNO INTEGER key, name TEXT, image TEXT, price REAL, num INTEGER, sent INTEGER)");
    query.exec("SELECT * FROM unsentModel");

    if (query.next()) {
        return true;
    }
    else {
        return false;
    }
}
