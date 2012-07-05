import QtQuick 1.0
import "../js/global.js" as Global

ListModel {
    id: startModel
    Component.onCompleted: loadItemsData()
  //Component.onDestruction: saveItemsData()
    function loadItemsData() {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                tx.executeSql('CREATE TABLE IF NOT EXISTS startModel(cid INTEGER primary key, cursor INTEGER, title TEXT, image TEXT, style TEXT, slotQml TEXT, rectColor TEXT, hotColor TEXT)');
                var rs = tx.executeSql('SELECT * FROM startModel');
                var index = 0;
                if (rs.rows.length > 0) {
                    while (index < rs.rows.length) {
                        var item0 = rs.rows.item(index);
                        var item1;
                        var item2;
                        if (index + 2 == rs.rows.length) {
                            item1 = rs.rows.item(index+1);
                            item2 = '';
                        }
                        else if (index + 1 == rs.rows.length) {                         
                            item1 = '';
                            item2 = '';
                        }
                        else {
                            item1 = rs.rows.item(index+1);
                            item2 = rs.rows.item(index+2);
                        }

                        startModel.append({"segment": Math.floor(index/9),
                                           "column": [{"cid": item0.cid, "cursor": item0.cursor, "title": item0.title, "image": item0.image, "style": item0.style, "slotQml": item0.slotQml, "rectColor": item0.rectColor, "hotColor": item0.hotColor},
                                                      {"cid": item1.cid, "cursor": item1.cursor, "title": item1.title, "image": item1.image, "style": item1.style, "slotQml": item1.slotQml, "rectColor": item1.rectColor, "hotColor": item1.hotColor},
                                                      {"cid": item2.cid, "cursor": item2.cursor, "title": item2.title, "image": item2.image, "style": item2.style, "slotQml": item2.slotQml, "rectColor": item2.rectColor, "hotColor": item2.hotColor}]});
                        index+=3;
                    }
                } else {
                    startModel.append({"segment": 0,
                                       "column": [{"cid": 0, cursor: 0, "title": "特 色", "image": "file:///sdcard/taomi-android/pics/AlmondCookies.png", "style": "IMAGE_RECT", "slotQml": "ItemsView.qml", "rectColor": "#de9317", "hotColor": "#d54d34"},
                                                  {"cid": 1, cursor: 0, "title": "购物车", "image": "qrc:/images/note.png", "style": "ICON_RECT", "slotQml": "ShopcarView.qml", "rectColor": "#5859b9", "hotColor": "#d54d34"},
                                                  {"cid": 2, cursor: 0, "title": "套 餐", "image": "file:///sdcard/taomi-android/pics/Blueberry_muffins.png", "style": "IMAGE_RECT", "slotQml": "ItemsView.qml", "rectColor": "#96b232", "hotColor": "#4eb3b9"}]});
                    startModel.append({"segment": 0,
                                       "column": [{"cid": 3, cursor: 0, "title": "优 惠", "image": "qrc:/images/skaner.png", "style": "ICON_RECT", "slotQml": "rect.qml", "rectColor": "#034888", "hotColor": "#d54d34"},
                                                  {"cid": 4, cursor: 0, "title": "座 位", "image": "qrc:/images/POI.png", "style": "ICON_RECT", "slotQml": "SeatView.qml", "rectColor": "#6e155f", "hotColor": "#d54d34"},
                                                  {"cid": 5, cursor: 0, "title": "主 食", "image": "file:///sdcard/taomi-android/pics/Briwates_Recipe.png", "style": "IMAGE_RECT", "slotQml": "ItemsView.qml", "rectColor": "#96b232", "hotColor": "#6e155f"}]});
                    startModel.append({"segment": 0,
                                       "column": [{"cid": 6, cursor: 0, "title": "浓 汤", "image":  "file:///sdcard/taomi-android/pics/BimBimBop.png", "style": "IMAGE_RECT", "slotQml": "ItemsView.qml", "rectColor": "#d54d34", "hotColor": "#de9317"},
                                                  {"cid": 7, cursor: 0, "title": "小 食", "image": "file:///sdcard/taomi-android/pics/Blueberry_cake.png", "style": "IMAGE_RECT", "slotQml": "ItemsView.qml", "rectColor": "#4eb3b9", "hotColor": "#96b232"},
                                                  {"cid": 8, cursor: 0, "title": "设 置", "image": "qrc:/images/sett-big.png", "style": "ICON_RECT", "slotQml": "rect.qml", "rectColor": "#de9317", "hotColor": "#d54d34"}]});

                    startModel.append({"segment": 1,
                                       "column": [{"cid": 9, cursor: 0, "title": "红 酒", "image": "file:///sdcard/taomi-android/pics/Briwates.png", "style": "IMAGE_RECT", "slotQml": "ItemsView.qml", "rectColor": "#FF0097", "hotColor": "#d54d34"},
                                                  {"cid": 10, cursor: 0, "title": "甜 品", "image": "file:///sdcard/taomi-android/pics/Briwates_Recipe.png", "style": "IMAGE_RECT", "slotQml": "ItemsView.qml", "rectColor": "#6e155f", "hotColor": "#d54d34"},
                                                  {"cid": 11, cursor: 0, "title": "拼 盘", "image": "file:///sdcard/taomi-android/pics/Butter_Nut_Soup.png", "style": "IMAGE_RECT", "slotQml": "ItemsView.qml", "rectColor": "#96b232", "hotColor": "#4eb3b9"}]});
                    startModel.append({"segment": 1,
                                       "column": [{"cid": 12, cursor: 0, "title": "记 录", "image": "qrc:/images/tasks.png", "style": "ICON_RECT", "slotQml": "rect.qml", "rectColor": "#96b232", "hotColor": "#d54d34"},
                                                  {"cid": 13, cursor: 0, "title": "炒 饭", "image": "file:///sdcard/taomi-android/pics/camping_breakfast.png", "style": "IMAGE_RECT", "slotQml": "ItemsView.qml", "rectColor": "#034888", "hotColor": "#d54d34"},
                                                  {"cid": 14, cursor: 0, "title": "新 闻", "image": "qrc:/images/rss.png", "style": "ICON_RECT", "slotQml": "rect.qml", "rectColor": "#de9317", "hotColor": "#d54d34"}]});
                    startModel.append({"segment": 1,
                                       "column": [{"cid": 15, cursor: 0, "title": "食 谱", "image": "file:///sdcard/taomi-android/pics/camping_breakfast_copping.png", "style": "IMAGE_RECT", "slotQml": "ItemsView.qml", "rectColor": "#1BA1E2", "hotColor": "#d54d34"},
                                                  {"cid": 16, cursor: 0, "title": "视 频", "image": "qrc:/images/video.png", "style": "ICON_RECT", "slotQml": "rect.qml", "rectColor": "#4eb3b9", "hotColor": "#d54d34"},
                                                  {"cid": 17, cursor: 0, "title": "搜 索", "image": "qrc:/images/search.png", "style": "ICON_RECT", "slotQml": "rect.qml", "rectColor": "#5859b9", "hotColor": "#4eb3b9"}]});

                    startModel.append({"segment": 2,
                                       "column": [{"cid": 18, cursor: 0, "title": "风 味", "image": "file:///sdcard/taomi-android/pics/CheeseStraws.png", "style": "IMAGE_RECT", "slotQml": "ItemsView.qml", "rectColor": "#d54d34", "hotColor": "#d54d34"},
                                                  {"cid": 19, cursor: 0, "title": "时 蔬", "image": "file:///sdcard/taomi-android/pics/Chermoula_aubergine.png", "style": "IMAGE_RECT", "slotQml": "ItemsView.qml", "rectColor": "#de9317", "hotColor": "#d54d34"},
                                                  {"cid": 20, cursor: 0, "title": "煲 仔", "image": "file:///sdcard/taomi-android/pics/Cherries.png", "style": "IMAGE_RECT", "slotQml": "ItemsView.qml", "rectColor": "#6e155f", "hotColor": "#4eb3b9"}]});
                    startModel.append({"segment": 2,
                                       "column": [{"cid": 21, cursor: 0, "title": "沙 拉", "image": "file:///sdcard/taomi-android/pics/Soft_Scamble_Breakfast.png", "style": "IMAGE_RECT", "slotQml": "ItemsView.qml", "rectColor": "#5859b9", "hotColor": "#d54d34"},
                                                  {"cid": 22, cursor: 0, "title": "水 果", "image":  "file:///sdcard/taomi-android/pics/Tagine.png", "style": "IMAGE_RECT", "slotQml": "ItemsView.qml", "rectColor": "#034888", "hotColor": "#d54d34"},
                                                  {"cid": 23, cursor: 0, "title": "喜 欢", "image": "qrc:/images/favs.png", "style": "ICON_RECT", "slotQml": "rect.qml", "rectColor": "#FF0097", "hotColor": "#4eb3b9"}]});
                }
            }
        )
    }

    function saveItemsData() {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
        db.transaction(
            function(tx) {
                tx.executeSql('DROP TABLE startModel');
                tx.executeSql('CREATE TABLE IF NOT EXISTS startModel(cid INTEGER primary key, cursor INTEGER, title TEXT, image TEXT, style TEXT, slotQml TEXT, rectColor TEXT, hotColor TEXT)');
                var index = 0;
                while (index < startModel.count) {
                    var item0 = startModel.get(index).column.get(0);
                    var item1 = startModel.get(index).column.get(1);
                    var item2 = startModel.get(index).column.get(2);
                    tx.executeSql('INSERT INTO startModel VALUES(?,?,?,?,?,?,?,?)', [item0.cid, item0.cursor, item0.title, item0.image, item0.style, item0.slotQml, item0.rectColor, item0.hotColor]);
                    tx.executeSql('INSERT INTO startModel VALUES(?,?,?,?,?,?,?,?)', [item1.cid, item1.cursor, item1.title, item1.image, item1.style, item1.slotQml, item1.rectColor, item1.hotColor]);
                    tx.executeSql('INSERT INTO startModel VALUES(?,?,?,?,?,?,?,?)', [item2.cid, item2.cursor, item2.title, item2.image, item2.style, item2.slotQml, item2.rectColor, item2.hotColor]);
                    index++;
                }
            }
        )
    }
}
