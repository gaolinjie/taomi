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
                tx.executeSql('CREATE TABLE IF NOT EXISTS itemsData(iid INTEGER primary key, cid INTEGER, tag TEXT, name TEXT, image TEXT, detail TEXT, price REAL)');
                var rs = tx.executeSql('SELECT * FROM itemsData where cid = ?', [Global.cid]);
                var index = 0;
                if (rs.rows.length > 0) {
                    while (index < rs.rows.length) {
                        var item0 = rs.rows.item(index);
                        var item1 = rs.rows.item(index+1);
                        if (index + 1 == rs.rows.length) {
                            item1 = ''
                            itemsModel.append({"segment": Math.floor(index/6),
                                               "column": [{"iid": item0.iid, "cid": item0.cid, "tag": item0.tag, "name": item0.name, "image": item0.image, "detail": item0.detail, "price": item0.price}]});
                        }
                        else {
                            itemsModel.append({"segment": Math.floor(index/6),
                                               "column": [{"iid": item0.iid, "cid": item0.cid, "tag": item0.tag, "name": item0.name, "image": item0.image, "detail": item0.detail, "price": item0.price},
                                                             {"iid": item1.iid, "cid": item1.cid, "tag": item1.tag, "name": item1.name, "image": item1.image, "detail": item1.detail, "price": item1.price}]});
                        }
                        index+=2;
                    }
                } else {/*
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 0, "cid": 0, "tag": "特色", "name": "拌豆腐丝", "image": "file:///C:/Users/gao/pics/AlmondCookies.png", "detail": "", "price": 10.0},
                                                     {"iid": 1, "cid": 0, "tag": "特色", "name": "白切鸡", "image": "file:///C:/Users/gao/pics/asian_noodle_soup.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 2, "cid": 0, "tag": "特色", "name": "白菜心拌蜇头", "image": "file:///C:/Users/gao/pics/baba-ganoush.png", "detail": "", "price": 10.0},
                                                     {"iid": 3, "cid": 0, "tag": "特色", "name": "白灵菇扣鸭掌", "image": "file:///C:/Users/gao/pics/Basil.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 4, "cid": 0, "tag": "特色", "name": "拌双耳", "image": "file:///C:/Users/gao/pics/BasilDrawing.png", "detail": "", "price": 10.0},
                                                     {"iid": 5, "cid": 0, "tag": "特色", "name": "冰梅凉瓜", "image": "file:///C:/Users/gao/pics/BerryPie.png", "detail": "", "price": 10.5}]});
                    itemsModel.append({"segment": 1,
                                          "column": [{"iid": 6, "cid": 0, "tag": "特色", "name": "冰镇芥兰", "image": "file:///C:/Users/gao/pics/BimBimBop.png", "detail": "", "price": 10.0},
                                                     {"iid": 7, "cid": 0, "tag": "特色", "name": "白灵菇扣鸭掌", "image": "file:///C:/Users/gao/pics/Blueberry_cake.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 8, "cid": 2, "tag": "套餐", "name": "朝鲜辣白菜", "image": "file:///C:/Users/gao/pics/Blueberry_muffins.png", "detail": "", "price": 10.0},
                                                     {"iid": 9, "cid": 2, "tag": "套餐", "name": "陈皮兔肉", "image": "file:///C:/Users/gao/pics/Briwates.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 10, "cid": 5, "tag": "主食", "name": "川北凉粉", "image": "file:///C:/Users/gao/pics/Briwates_Recipe.png", "detail": "", "price": 10.0},
                                                     {"iid": 11, "cid": 5, "tag": "主食", "name": "刺身凉瓜", "image": "file:///C:/Users/gao/pics/Butter_Nut_Soup.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 12, "cid": 6, "tag": "浓汤", "name": "豆豉多春鱼", "image": "file:///C:/Users/gao/pics/butternut_squash_salad.png", "detail": "", "price": 10.0},
                                                     {"iid": 13, "cid": 6, "tag": "浓汤", "name": "夫妻肺片", "image": "file:///C:/Users/gao/pics/camping_breakfast.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 14, "cid": 7, "tag": "小食", "name": "干拌牛舌", "image": "file:///C:/Users/gao/pics/camping_breakfast_coffee.png", "detail": "", "price": 10.0},
                                                     {"iid": 15, "cid": 7, "tag": "小食", "name": "干拌顺风", "image": "file:///C:/Users/gao/pics/camping_breakfast_copping.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 16, "cid": 9, "tag": "红酒", "name": "怪味牛腱", "image": "file:///C:/Users/gao/pics/camping_breakfast_stirring.png", "detail": "", "price": 10.0},
                                                     {"iid": 17, "cid": 9, "tag": "红酒", "name": "红心鸭卷", "image": "file:///C:/Users/gao/pics/Carrot-Ginger-Soup.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 18, "cid": 10, "tag": "甜品", "name": "怪味牛腱", "image": "file:///C:/Users/gao/pics/CheeseStraws.png", "detail": "", "price": 10.0},
                                                     {"iid": 19, "cid": 10, "tag": "甜品", "name": "红心鸭卷", "image": "file:///C:/Users/gao/pics/Chermoula_aubergine.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 20, "cid": 11, "tag": "拼盘", "name": "怪味牛腱", "image": "file:///C:/Users/gao/pics/Cherries.png", "detail": "", "price": 10.0},
                                                     {"iid": 21, "cid": 11, "tag": "拼盘", "name": "红心鸭卷", "image": "file:///C:/Users/gao/pics/Cherry_amandines.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 22, "cid": 13, "tag": "炒饭", "name": "怪味牛腱", "image": "file:///C:/Users/gao/pics/Christmas_Brunch.png", "detail": "", "price": 10.0},
                                                     {"iid": 23, "cid": 13, "tag": "炒饭", "name": "红心鸭卷", "image": "file:///C:/Users/gao/pics/ChristopherBreakfast.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 24, "cid": 15, "tag": "食谱", "name": "怪味牛腱", "image": "file:///C:/Users/gao/pics/Cranberry_Sauce.png", "detail": "", "price": 10.0},
                                                     {"iid": 25, "cid": 15, "tag": "食谱", "name": "红心鸭卷", "image": "file:///C:/Users/gao/pics/crimini_mushrooms_pasta.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 26, "cid": 18, "tag": "风味", "name": "怪味牛腱", "image": "file:///C:/Users/gao/pics/Crushed_pea_tartines.png", "detail": "", "price": 10.0},
                                                     {"iid": 27, "cid": 18, "tag": "风味", "name": "红心鸭卷", "image": "file:///C:/Users/gao/pics/Curry_laksa_soup.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 28, "cid": 19, "tag": "时蔬", "name": "怪味牛腱", "image": "file:///C:/Users/gao/pics/Kermit-Lynch-Wine.png", "detail": "", "price": 10.0},
                                                     {"iid": 29, "cid": 19, "tag": "时蔬", "name": "红心鸭卷", "image": "file:///C:/Users/gao/pics/rustic_soup.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 30, "cid": 20, "tag": "煲仔", "name": "怪味牛腱", "image": "file:///C:/Users/gao/pics/Salmon_with_pesto.png", "detail": "", "price": 10.0},
                                                     {"iid": 31, "cid": 20,"tag": "煲仔", "name": "红心鸭卷", "image": "file:///C:/Users/gao/pics/SeaFoodStew.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 32, "cid": 21, "tag": "沙拉", "name": "怪味牛腱", "image": "file:///C:/Users/gao/pics/Soft_Scamble_Breakfast.png", "detail": "", "price": 10.0},
                                                     {"iid": 33, "cid": 21, "tag": "沙拉", "name": "红心鸭卷", "image": "file:///C:/Users/gao/pics/Summer_Salad.png", "detail": "", "price": 10.5}]});

                    itemsModel.append({"segment": 0,
                                          "column": [{"iid": 34, "cid": 22, "tag": "水果", "name": "怪味牛腱", "image": "file:///C:/Users/gao/pics/Tagine.png", "detail": "", "price": 10.0},
                                                     {"iid": 35, "cid": 22, "tag": "水果", "name": "红心鸭卷", "image": "file:///C:/Users/gao/pics/Tagine_Recipe.png", "detail": "", "price": 10.5}]});

                */}
            }
        )
    }

    function saveItemsData() {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                tx.executeSql('DROP TABLE itemsData');
                tx.executeSql('CREATE TABLE IF NOT EXISTS itemsData(iid INTEGER primary key, cid INTEGER, tag TEXT, name TEXT, image TEXT, detail TEXT, price REAL)');
                var index = 0;
                while (index < itemsModel.count) {
                    var item1 = itemsModel.get(index).column.get(0);
                    var item2 = itemsModel.get(index).column.get(1);
                    tx.executeSql('INSERT INTO itemsData VALUES(?,?,?,?,?,?,?)', [item1.iid, item1.cid, item1.tag, item1.name, item1.image, item1.detail, item1.price]);
                    tx.executeSql('INSERT INTO itemsData VALUES(?,?,?,?,?,?,?)', [item2.iid, item2.cid, item2.tag, item2.name, item2.image, item2.detail, item2.price]);
                    index++;
                }
            }
        )
    }
}
