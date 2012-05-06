import QtQuick 1.0
import "../js/global.js" as Global

ListModel {
    id: itemsModel
    Component.onCompleted: loadItemsData()
//  Component.onDestruction: saveItemsData()
    function loadItemsData() {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                tx.executeSql('CREATE TABLE IF NOT EXISTS itemsData(iid INTEGER primary key, cursor INTEGER, cid INTEGER, tag TEXT, name TEXT, image TEXT, detail TEXT, price REAL)');
                var rs = tx.executeSql('SELECT * FROM itemsData where tag = ?', [Global.tag]);
                var index = 0;
                if (rs.rows.length > 0) {
                    while (index < rs.rows.length) {
                        var item0 = rs.rows.item(index);
                        var item1 = rs.rows.item(index+1);
                        if (index + 1 == rs.rows.length) {
                            item1 = ''
                        }

                        itemsModel.append({"segment": Math.floor(index/6),
                                           "column": [{"iid": item0.iid, "cursor": item0.cursor, "cid": item0.cid, "tag": item0.tag, "name": item0.name, "image": item0.image, "detail": item0.detail, "price": item0.price},
                                                         {"iid": item1.iid, "cursor": item1.cursor, "cid": item1.cid, "tag": item1.tag, "name": item1.name, "image": item1.image, "detail": item1.detail, "price": item1.price}]});
                        index+=2;
                    }
                } else {
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 0, "cursor": 0, "cid": 0, "tag": "特色", "name": "拌豆腐丝", "image": "qrc:/images/AlmondCookies.png", "detail": "", "price": 10.0},
                                                     {"iid": 1, "cursor": 0, "cid": 0, "tag": "特色", "name": "白切鸡", "image": "qrc:/images/asian_noodle_soup.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 2, "cursor": 0, "cid": 0, "tag": "特色", "name": "白菜心拌蜇头", "image": "qrc:/images/baba-ganoush.png", "detail": "", "price": 10.0},
                                                     {"iid": 3, "cursor": 0, "cid": 0, "tag": "特色", "name": "白灵菇扣鸭掌", "image": "qrc:/images/Basil.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 4, "cursor": 0, "cid": 0, "tag": "特色", "name": "拌双耳", "image": "qrc:/images/BasilDrawing.png", "detail": "", "price": 10.0},
                                                     {"iid": 5, "cursor": 0, "cid": 0, "tag": "特色", "name": "冰梅凉瓜", "image": "qrc:/images/BerryPie.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 1,
                                          "column": [{"iid": 6, "cursor": 0, "cid": 0, "tag": "特色", "name": "冰镇芥兰", "image": "qrc:/images/BimBimBop.png", "detail": "", "price": 10.0},
                                                     {"iid": 7, "cursor": 0, "cid": 0, "tag": "特色", "name": "白灵菇扣鸭掌", "image": "qrc:/images/Blueberry_cake.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 8, "cursor": 0, "cid": 1, "tag": "套餐", "name": "朝鲜辣白菜", "image": "qrc:/images/Blueberry_muffins.png", "detail": "", "price": 10.0},
                                                     {"iid": 9, "cursor": 0, "cid": 1, "tag": "套餐", "name": "陈皮兔肉", "image": "qrc:/images/Briwates.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 10, "cursor": 0, "cid": 2, "tag": "主食", "name": "川北凉粉", "image": "qrc:/images/Briwates_Recipe.png", "detail": "", "price": 10.0},
                                                     {"iid": 11, "cursor": 0, "cid": 2, "tag": "主食", "name": "刺身凉瓜", "image": "qrc:/images/Butter_Nut_Soup.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 12, "cursor": 0, "cid": 3, "tag": "浓汤", "name": "豆豉多春鱼", "image": "qrc:/images/butternut_squash_salad.png", "detail": "", "price": 10.0},
                                                     {"iid": 13, "cursor": 0, "cid": 3, "tag": "浓汤", "name": "夫妻肺片", "image": "qrc:/images/camping_breakfast.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 14, "cursor": 0, "cid": 4, "tag": "小食", "name": "干拌牛舌", "image": "qrc:/images/camping_breakfast_coffee.png", "detail": "", "price": 10.0},
                                                     {"iid": 15, "cursor": 0, "cid": 4, "tag": "小食", "name": "干拌顺风", "image": "qrc:/images/camping_breakfast_copping.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 16, "cursor": 0, "cid": 5, "tag": "红酒", "name": "怪味牛腱", "image": "qrc:/images/camping_breakfast_stirring.png", "detail": "", "price": 10.0},
                                                     {"iid": 17, "cursor": 0, "cid": 5, "tag": "红酒", "name": "红心鸭卷", "image": "qrc:/images/Carrot-Ginger-Soup.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 18, "cursor": 0, "cid": 6, "tag": "甜品", "name": "怪味牛腱", "image": "qrc:/images/CheeseStraws.png", "detail": "", "price": 10.0},
                                                     {"iid": 19, "cursor": 0, "cid": 6, "tag": "甜品", "name": "红心鸭卷", "image": "qrc:/images/Chermoula_aubergine.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 20, "cursor": 0, "cid": 7, "tag": "拼盘", "name": "怪味牛腱", "image": "qrc:/images/Cherries.png", "detail": "", "price": 10.0},
                                                     {"iid": 21, "cursor": 0, "cid": 7, "tag": "拼盘", "name": "红心鸭卷", "image": "qrc:/images/Cherry_amandines.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 22, "cursor": 0, "cid": 8, "tag": "炒饭", "name": "怪味牛腱", "image": "qrc:/images/Christmas_Brunch.png", "detail": "", "price": 10.0},
                                                     {"iid": 23, "cursor": 0, "cid": 8, "tag": "炒饭", "name": "红心鸭卷", "image": "qrc:/images/ChristopherBreakfast.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 24, "cursor": 0, "cid": 9, "tag": "食谱", "name": "怪味牛腱", "image": "qrc:/images/Cranberry_Sauce.png", "detail": "", "price": 10.0},
                                                     {"iid": 25, "cursor": 0, "cid": 9, "tag": "食谱", "name": "红心鸭卷", "image": "qrc:/images/crimini_mushrooms_pasta.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 26, "cursor": 0, "cid": 10, "tag": "风味", "name": "怪味牛腱", "image": "qrc:/images/Crushed_pea_tartines.png", "detail": "", "price": 10.0},
                                                     {"iid": 27, "cursor": 0, "cid": 10, "tag": "风味", "name": "红心鸭卷", "image": "qrc:/images/Curry_laksa_soup.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 28, "cursor": 0, "cid": 11, "tag": "时蔬", "name": "怪味牛腱", "image": "qrc:/images/Kermit-Lynch-Wine.png", "detail": "", "price": 10.0},
                                                     {"iid": 29, "cursor": 0, "cid": 11, "tag": "时蔬", "name": "红心鸭卷", "image": "qrc:/images/rustic_soup.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 30, "cursor": 0, "cid": 12, "tag": "煲仔", "name": "怪味牛腱", "image": "qrc:/images/Salmon_with_pesto.png", "detail": "", "price": 10.0},
                                                     {"iid": 31, "cursor": 0, "cid": 12,"tag": "煲仔", "name": "红心鸭卷", "image": "qrc:/images/SeaFoodStew.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 32, "cursor": 0, "cid": 13, "tag": "沙拉", "name": "怪味牛腱", "image": "qrc:/images/Soft_Scamble_Breakfast.png", "detail": "", "price": 10.0},
                                                     {"iid": 33, "cursor": 0, "cid": 13, "tag": "沙拉", "name": "红心鸭卷", "image": "qrc:/images/Summer_Salad.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 34, "cursor": 0, "cid": 14, "tag": "水果", "name": "怪味牛腱", "image": "qrc:/images/Tagine.png", "detail": "", "price": 10.0},
                                                     {"iid": 35, "cursor": 0, "cid": 14, "tag": "水果", "name": "红心鸭卷", "image": "qrc:/images/Tagine_Recipe.png", "detail": "", "price": 10.5}]});

                }
            }
        )
    }

    function saveItemsData() {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                tx.executeSql('DROP TABLE itemsData');
                tx.executeSql('CREATE TABLE IF NOT EXISTS itemsData(iid INTEGER primary key, cursor INTEGER, cid INTEGER, tag TEXT, name TEXT, image TEXT, detail TEXT, price REAL)');
                var index = 0;
                while (index < itemsModel.count) {
                    var item1 = itemsModel.get(index).column.get(0);
                    var item2 = itemsModel.get(index).column.get(1);
                    tx.executeSql('INSERT INTO itemsData VALUES(?,?,?,?,?,?,?,?)', [item1.iid, item1.cursor, item1.cid, item1.tag, item1.name, item1.image, item1.detail, item1.price]);
                    tx.executeSql('INSERT INTO itemsData VALUES(?,?,?,?,?,?,?,?)', [item2.iid, item2.cursor, item2.cid, item2.tag, item2.name, item2.image, item2.detail, item2.price]);
                    index++;
                }
            }
        )
    }
}
