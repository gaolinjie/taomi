#include "refreshmanager.h"
#include <QtSql>
#include <QDebug>

#define TAG "[OrderManager]"

RefreshManager::RefreshManager(QObject *parent) :
    QObject(parent)
{
    // 临时
    /*
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS startModel(id INTEGER primary key, cid INTEGER, cursor INTEGER)");
    query.exec("INSERT INTO startModel(id, cid, cursor) VALUES (0, 0, 0)");
    query.exec("INSERT INTO startModel(id, cid, cursor) VALUES (1, 1, 0)");
    query.exec("INSERT INTO startModel(id, cid, cursor) VALUES (2, 2, 0)");
    query.exec("INSERT INTO startModel(id, cid, cursor) VALUES (3, 3, 0)");
    query.exec("INSERT INTO startModel(id, cid, cursor) VALUES (4, 4, 0)");
    query.exec("INSERT INTO startModel(id, cid, cursor) VALUES (5, 5, 0)");
    query.exec("INSERT INTO startModel(id, cid, cursor) VALUES (6, 6, 0)");
    query.exec("INSERT INTO startModel(id, cid, cursor) VALUES (7, 7, 0)");
    query.exec("INSERT INTO startModel(id, cid, cursor) VALUES (8, 8, 0)");
    query.exec("INSERT INTO startModel(id, cid, cursor) VALUES (9, 9, 0)");
    query.exec("INSERT INTO startModel(id, cid, cursor) VALUES (10, 10, 0)");
    query.exec("INSERT INTO startModel(id, cid, cursor) VALUES (11, 11, 0)");
    query.exec("INSERT INTO startModel(id, cid, cursor) VALUES (12, 12, 0)");
    query.exec("INSERT INTO startModel(id, cid, cursor) VALUES (13, 13, 0)");
    query.exec("INSERT INTO startModel(id, cid, cursor) VALUES (14, 14, 0)");
    */
}

QString RefreshManager::getImageNext(quint16 cid)
{
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS startModel(id INTEGER primary key, cid INTEGER, cursor INTEGER)");
    query.prepare("SELECT * FROM startModel WHERE cid = ?");
    query.addBindValue(cid);
    query.exec();

    quint16 cursor = 0;
    if (query.next()) {
        cursor = query.value(2).toUInt();
    }

    query.exec("CREATE TABLE IF NOT EXISTS itemsData(id INTEGER primary key, cid INTEGER, tag TEXT, name TEXT, image TEXT, detail TEXT, price REAL)");
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

    ++cursor;
    if (cursor >= c) {
        cursor = 0;
    }

    query.prepare("UPDATE startModel SET cursor = ? WHERE cid = ?");
    query.addBindValue(cursor);
    query.addBindValue(cid);
    query.exec();

    return image;
}
