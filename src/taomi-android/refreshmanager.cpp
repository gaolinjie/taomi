#include "refreshmanager.h"
#include <QtSql>
#include <QDebug>

#define TAG "[RefreshManager]"

RefreshManager::RefreshManager(QObject *parent) :
    QObject(parent)
{
}

QString RefreshManager::getImageNext(quint16 cid)
{
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS startModel(cid INTEGER primary key, cursor INTEGER, title TEXT, image TEXT, style TEXT, slotQml TEXT, rectColor TEXT, hotColor TEXT)");
    query.prepare("SELECT * FROM startModel WHERE cid = ?");
    query.addBindValue(cid);
    query.exec();

    quint16 cursor = 0;
    if (query.next()) {
        cursor = query.value(1).toUInt();
    } 

    query.exec("CREATE TABLE IF NOT EXISTS itemsData(iid INTEGER primary key, cid INTEGER, tag TEXT, name TEXT, image TEXT, detail TEXT, price REAL)");
    query.prepare("SELECT * FROM itemsData WHERE cid = ?");
    query.addBindValue(cid);
    query.exec();

    QString image;
    quint16 c = 0;
    while (query.next()) {
        if (c == cursor) {
            image = query.value(4).toString();
        }
        c++;
    }

    if (image == "") {
        return image;
    }

    ++cursor;
    if (cursor >= c) {
        cursor = 0;
    }

    query.prepare("UPDATE startModel SET cursor = ?, image = ? WHERE cid = ?");
    query.addBindValue(cursor);
    query.addBindValue(image);
    query.addBindValue(cid);
    query.exec();

    return image;
}

quint16 RefreshManager::getRandom()
{
    quint16 r = (qrand()%8+1)*100 + (qrand()%8+1)*1000 + qrand()%3*10000;
    qDebug() << QString("%1").arg(r);
    return r;
}
