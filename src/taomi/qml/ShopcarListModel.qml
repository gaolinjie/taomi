import QtQuick 1.0

ListModel {
    id: shopcarListModel
    Component.onCompleted: loadItemsData()
    Component.onDestruction: saveItemsData()
    function loadItemsData() {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                tx.executeSql('CREATE TABLE IF NOT EXISTS sentModel(orderNO INTEGER key, name TEXT, image TEXT, price REAL, num INTEGER, sent INTEGER)');
                var rs = tx.executeSql('SELECT * FROM sentModel');
                var index = 0;
                if (rs.rows.length > 0) {
                    while (index < rs.rows.length) {
                        var item = rs.rows.item(index);
                        shopcarListModel.append({"orderNO": item.orderNO,
                                             "name": item.name,
                                             "image": item.image,
                                             "price": item.price,
                                             "num": item.num,
                                             "sent": item.sent});
                        index++;
                    }
                }

                tx.executeSql('CREATE TABLE IF NOT EXISTS unsentModel(orderNO INTEGER key, name TEXT, image TEXT, price REAL, num INTEGER, sent INTEGER)');
                rs = tx.executeSql('SELECT * FROM unsentModel');
                index = 0;
                if (rs.rows.length > 0) {
                    while (index < rs.rows.length) {
                        item = rs.rows.item(index);
                        shopcarListModel.append({"orderNO": item.orderNO,
                                             "name": item.name,
                                             "image": item.image,
                                             "price": item.price,
                                             "num": item.num,
                                             "sent": item.sent});
                        index++;
                    }
                }
            }
        )
    }

    function saveItemsData() {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                tx.executeSql('DROP TABLE sentModel');
                tx.executeSql('CREATE TABLE IF NOT EXISTS sentModel(orderNO INTEGER key, name TEXT, image TEXT, price REAL, num INTEGER, sent INTEGER)');
                tx.executeSql('DROP TABLE unsentModel');
                tx.executeSql('CREATE TABLE IF NOT EXISTS unsentModel(orderNO INTEGER key, name TEXT, image TEXT, price REAL, num INTEGER, sent INTEGER)');
                var index = 0;
                while (index < shopcarListModel.count) {
                    var item = shopcarListModel.get(index);
                    if (item.sent == 1) {
                        tx.executeSql('INSERT INTO sentModel VALUES(?,?,?,?,?,?)', [item.orderNO, item.name, item.image, item.price, item.num, item.sent]);
                        index++;
                    }
                    else {
                        tx.executeSql('INSERT INTO unsentModel VALUES(?,?,?,?,?,?)', [item.orderNO, item.name, item.image, item.price, item.num, item.sent]);
                        index++;
                    }
                }
            }
        )
    }
}
