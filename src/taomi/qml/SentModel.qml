import QtQuick 1.0

ListModel {
    id: sentModel
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
                        sentModel.append({"orderNO": item.orderNO,
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
                var index = 0;
                while (index < sentModel.count) {
                    var item = sentModel.get(index);
                    tx.executeSql('INSERT INTO sentModel VALUES(?,?,?,?,?,?)', [item.orderNO, item.name, item.image, item.price, item.num, item.sent]);
                    index++;
                }
            }
        )
    }
}
