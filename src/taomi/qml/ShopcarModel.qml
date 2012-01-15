import QtQuick 1.0

ListModel {
    id: shopcarModel
    Component.onCompleted: loadItemsData()
    Component.onDestruction: saveItemsData()
    function loadItemsData() {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                //tx.executeSql('DROP TABLE shopcarData');
                // Create the database if it doesn't already exist
                //
                tx.executeSql('CREATE TABLE IF NOT EXISTS shopcarData(name TEXT, image TEXT, price MONEY, num INTEGER)');
                var rs = tx.executeSql('SELECT * FROM shopcarData');
                var index = 0;
                if (rs.rows.length > 0) {
                    while (index < rs.rows.length) {
                        var item = rs.rows.item(index);
                        shopcarModel.append({"name": item.name,
                                             "image": item.image,
                                             "price": item.price,
                                             "num": item.num});
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
                tx.executeSql('DROP TABLE shopcarData');
                tx.executeSql('CREATE TABLE IF NOT EXISTS shopcarData(name TEXT, image TEXT, price MONEY, num INTEGER)');
                var index = 0;
                while (index < shopcarModel.count) {
                    var item = shopcarModel.get(index);
                    tx.executeSql('INSERT INTO shopcarData VALUES(?,?,?,?)', [item.name, item.image, item.price, item.num]);
                    index++;
                }
            }
        )
    }
}
