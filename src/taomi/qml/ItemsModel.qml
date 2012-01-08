import QtQuick 1.0
import "../js/global.js" as Global

ListModel {
    id: itemsModel
    Component.onCompleted: loadItemsData()
  //Component.onDestruction: saveItemsData()
    function loadItemsData() {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                //tx.executeSql('DROP TABLE itemsData');
                // Create the database if it doesn't already exist
                //
                tx.executeSql('CREATE TABLE IF NOT EXISTS itemsData(id INTEGER primary key, tag TEXT, name TEXT, image TEXT)');
                //var rs = tx.executeSql('SELECT * FROM itemsData ORDER BY id');
                var rs = tx.executeSql('SELECT * FROM itemsData WHERE tag = ?', [Global.tag]);
                var index = 0;
                if (rs.rows.length > 0) {
                    while (index < rs.rows.length) {
                        var item0 = rs.rows.item(index);
                        var item1 = rs.rows.item(index+1);
                        if (index + 1 == rs.rows.length) {
                            item1 = ''
                        }

                        itemsModel.append({"segment": Math.floor(index/6),
                                           "column": [{"name": item0.name, "image": item0.image},
                                                      {"name": item1.name, "image": item1.image}]});
                        console.log(item0.id)
                        console.log(item1.id)
                        index+=2;
                    }
                } else {
                    itemsModel.append({"id": 0,
                                       "tag": "特色",
                                       "name": "Tagine",
                                       "image": "qrc:/images/Tagine.jpg"});
                    itemsModel.append({"id": 1,
                                       "tag": "特色",
                                       "name": "Soft Scamble Breakfast",
                                       "image": "qrc:/images/Soft_Scamble_Breakfast.jpg"});
                    itemsModel.append({"id": 2,
                                       "tag": "特色",
                                       "name": "BimBimBop",
                                       "image": "qrc:/images/BimBimBop.jpg"});
                    itemsModel.append({"id": 3,
                                       "tag": "特色",
                                       "name": "Tomato Basil Lasagne",
                                       "image": "qrc:/images/Tomato-Basil-Lasagne.jpg"});
                    itemsModel.append({"id": 4,
                                       "tag": "特色",
                                       "name": "Carrot Ginger Soup",
                                       "image": "qrc:/images/Carrot-Ginger-Soup.jpg"});
                    itemsModel.append({"id": 5,
                                       "tag": "特色",
                                       "name": "CheeseStraws",
                                       "image": "qrc:/images/CheeseStraws.jpg"});
                    itemsModel.append({"id": 6,
                                       "tag": "特色",
                                       "name": "Kermit Lynch Wine",
                                       "image": "qrc:/images/Kermit-Lynch-Wine.jpg"});
                    itemsModel.append({"id": 7,
                                       "tag": "特色",
                                       "name": "Blueberry muffins",
                                       "image": "qrc:/images/Blueberry_muffins.jpg"});
                    itemsModel.append({"id": 8,
                                       "tag": "特色",
                                       "name": "baba ganoush",
                                       "image": "qrc:/images/baba-ganoush.jpg"});
                    itemsModel.append({"id": 9,
                                       "tag": "特色",
                                       "name": "rustic soup",
                                       "image": "qrc:/images/rustic_soup.jpg"});
                    itemsModel.append({"id": 10,
                                       "tag": "特色",
                                       "name": "Tagine Recipe",
                                       "image": "qrc:/images/Tagine_Recipe.jpg"});
                    itemsModel.append({"id": 11,
                                       "tag": "特色",
                                       "name": "BimBimBop",
                                       "image": "qrc:/images/BimBimBop.jpg"});
                    itemsModel.append({"id": 12,
                                       "tag": "特色",
                                       "name": "rustic soup",
                                       "image": "qrc:/images/rustic_soup.jpg"});
                    itemsModel.append({"id": 13,
                                       "tag": "特色",
                                       "name": "Salmon with pesto",
                                       "image": "qrc:/images/Salmon_with_pesto.jpg"});
                    itemsModel.append({"id": 14,
                                       "tag": "特色",
                                       "name": "Summer Salad",
                                       "image": "qrc:/images/Summer_Salad.jpg"});
                    itemsModel.append({"id": 15,
                                       "tag": "特色",
                                       "name": "Cherries",
                                       "image": "qrc:/images/Cherries.jpg"});
                    itemsModel.append({"id": 16,
                                       "tag": "套餐",
                                       "name": "Blueberry muffins",
                                       "image": "qrc:/images/Blueberry_muffins.jpg"});
                    itemsModel.append({"id": 17,
                                       "tag": "套餐",
                                       "name": "baba ganoush",
                                       "image": "qrc:/images/baba-ganoush.jpg"});
                    itemsModel.append({"id": 18,
                                       "tag": "套餐",
                                       "name": "rustic soup",
                                       "image": "qrc:/images/rustic_soup.jpg"});
                    itemsModel.append({"id": 19,
                                       "tag": "套餐",
                                       "name": "Tagine Recipe",
                                       "image": "qrc:/images/Tagine_Recipe.jpg"});
                    itemsModel.append({"id": 20,
                                       "tag": "套餐",
                                       "name": "BimBimBop",
                                       "image": "qrc:/images/BimBimBop.jpg"});
                    itemsModel.append({"id": 21,
                                       "tag": "套餐",
                                       "name": "rustic soup",
                                       "image": "qrc:/images/rustic_soup.jpg"});
                    itemsModel.append({"id": 22,
                                       "tag": "套餐",
                                       "name": "Salmon with pesto",
                                       "image": "qrc:/images/Salmon_with_pesto.jpg"});
                    itemsModel.append({"id": 23,
                                       "tag": "套餐",
                                       "name": "Summer Salad",
                                       "image": "qrc:/images/Summer_Salad.jpg"});
                    itemsModel.append({"id": 24,
                                       "tag": "套餐",
                                       "name": "Cherries",
                                       "image": "qrc:/images/Cherries.jpg"});
                    itemsModel.append({"id": 25,
                                       "tag": "套餐",
                                       "name": "Tagine",
                                       "image": "qrc:/images/Tagine.jpg"});
                    itemsModel.append({"id": 26,
                                       "tag": "套餐",
                                       "name": "Soft Scamble Breakfast",
                                       "image": "qrc:/images/Soft_Scamble_Breakfast.jpg"});
                    itemsModel.append({"id": 27,
                                       "tag": "套餐",
                                       "name": "BimBimBop",
                                       "image": "qrc:/images/BimBimBop.jpg"});
                    itemsModel.append({"id": 28,
                                       "tag": "套餐",
                                       "name": "Tomato Basil Lasagne",
                                       "image": "qrc:/images/Tomato-Basil-Lasagne.jpg"});
                    itemsModel.append({"id": 29,
                                       "tag": "套餐",
                                       "name": "Carrot Ginger Soup",
                                       "image": "qrc:/images/Carrot-Ginger-Soup.jpg"});
                    itemsModel.append({"id": 30,
                                       "tag": "套餐",
                                       "name": "CheeseStraws",
                                       "image": "qrc:/images/CheeseStraws.jpg"});
                    itemsModel.append({"id": 31,
                                       "tag": "套餐",
                                       "name": "Kermit Lynch Wine",
                                       "image": "qrc:/images/Kermit-Lynch-Wine.jpg"});
                    itemsModel.append({"id": 32,
                                       "tag": "主食",
                                       "name": "Soft Scamble Breakfast",
                                       "image": "qrc:/images/Soft_Scamble_Breakfast.jpg"});
                    itemsModel.append({"id": 33,
                                       "tag": "主食",
                                       "name": "BimBimBop",
                                       "image": "qrc:/images/BimBimBop.jpg"});
                    itemsModel.append({"id": 34,
                                       "tag": "主食",
                                       "name": "Tomato Basil Lasagne",
                                       "image": "qrc:/images/Tomato-Basil-Lasagne.jpg"});
                    itemsModel.append({"id": 35,
                                       "tag": "主食",
                                       "name": "Carrot Ginger Soup",
                                       "image": "qrc:/images/Carrot-Ginger-Soup.jpg"});
                    itemsModel.append({"id": 36,
                                       "tag": "主食",
                                       "name": "CheeseStraws",
                                       "image": "qrc:/images/CheeseStraws.jpg"});
                    itemsModel.append({"id": 37,
                                       "tag": "主食",
                                       "name": "Kermit Lynch Wine",
                                       "image": "qrc:/images/Kermit-Lynch-Wine.jpg"});
                    itemsModel.append({"id": 38,
                                       "tag": "浓汤",
                                       "name": "CheeseStraws",
                                       "image": "qrc:/images/CheeseStraws.jpg"});
                    itemsModel.append({"id": 39,
                                       "tag": "浓汤",
                                       "name": "Kermit Lynch Wine",
                                       "image": "qrc:/images/Kermit-Lynch-Wine.jpg"});
                    itemsModel.append({"id": 40,
                                       "tag": "浓汤",
                                       "name": "Soft Scamble Breakfast",
                                       "image": "qrc:/images/Soft_Scamble_Breakfast.jpg"});
                    itemsModel.append({"id": 41,
                                       "tag": "浓汤",
                                       "name": "BimBimBop",
                                       "image": "qrc:/images/BimBimBop.jpg"});
                    itemsModel.append({"id": 42,
                                       "tag": "小食",
                                       "name": "BimBimBop",
                                       "image": "qrc:/images/BimBimBop.jpg"});
                    itemsModel.append({"id": 43,
                                       "tag": "小食",
                                       "name": "Tomato Basil Lasagne",
                                       "image": "qrc:/images/Tomato-Basil-Lasagne.jpg"});
                    itemsModel.append({"id": 44,
                                       "tag": "小食",
                                       "name": "Carrot Ginger Soup",
                                       "image": "qrc:/images/Carrot-Ginger-Soup.jpg"});
                    itemsModel.append({"id": 45,
                                       "tag": "小食",
                                       "name": "CheeseStraws",
                                       "image": "qrc:/images/CheeseStraws.jpg"});
                    itemsModel.append({"id": 46,
                                       "tag": "小食",
                                       "name": "Kermit Lynch Wine",
                                       "image": "qrc:/images/Kermit-Lynch-Wine.jpg"});
                    itemsModel.append({"id": 47,
                                       "tag": "小食",
                                       "name": "CheeseStraws",
                                       "image": "qrc:/images/CheeseStraws.jpg"});
                    itemsModel.append({"id": 48,
                                       "tag": "小食",
                                       "name": "Kermit Lynch Wine",
                                       "image": "qrc:/images/Kermit-Lynch-Wine.jpg"});
                    itemsModel.append({"id": 49,
                                       "tag": "小食",
                                       "name": "Soft Scamble Breakfast",
                                       "image": "qrc:/images/Soft_Scamble_Breakfast.jpg"});
                    itemsModel.append({"id": 50,
                                       "tag": "小食",
                                       "name": "BimBimBop",
                                       "image": "qrc:/images/BimBimBop.jpg"});
                }
            }
        )
    }

    function saveItemsData() {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                tx.executeSql('DROP TABLE itemsData');
                tx.executeSql('CREATE TABLE IF NOT EXISTS itemsData(id INTEGER primary key, tag TEXT, name TEXT, image TEXT)');
                var index = 0;
                while (index < itemsModel.count) {
                    var item = itemsModel.get(index);
                    tx.executeSql('INSERT INTO itemsData VALUES(?,?,?,?)', [item.id, item.tag, item.name, item.image]);
                    index++;
                }
            }
        )
    }
}
