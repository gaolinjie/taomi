import QtQuick 1.0

ListView {
    id: shopcarList
    x: 35; y: 100; width: 230; height:400
    model: shopcarListModel
    delegate: shopcarListDelegate
    cacheBuffer: 1000
    spacing: 20
    smooth: true
    section.property: "sent"
    section.criteria: ViewSection.FullString
    section.delegate: startSpace

    Connections {
        target: parent.parent
        onSaveShopcar: {
            shopcarListModel.saveItemsData();
        }
    }

    Component {
        id: startSpace
        Item {
            width: 300
            height: 60

            Text {
                id: categoryTitle
                text: section == "1"  ? "已发送的菜单" : "未发送的菜单"
                anchors.left: parent.left; anchors.leftMargin: -3
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20
                font.family: "微软雅黑"
                color: "white"
                smooth: true
            }

            Rectangle {
                id: separator
                width: 230; height: 2
                anchors.left: categoryTitle.left
                anchors.top: categoryTitle.bottom; anchors.topMargin: 5
                opacity: 0.6
            }
        }
    }

    Component {
        id: shopcarListDelegate

        Item {
            id: wraper2
            width: 64; height: 40

            Image {
                id: itemImage
                source: image
                sourceSize.width: 64
                sourceSize.height: 40
                anchors.left: parent.left
                anchors.top: parent.top
            }

            Text {
                id: nameText
                text: name
                x: 80; anchors.top: parent.top
                font.pixelSize: 16
                font.family: "微软雅黑"
                color: "white"
                smooth: true
            }

            Text {
                id: priceText
                text: "￥ " + price + " 元 x "
                x: 80; anchors.bottom: parent.bottom
                font.pixelSize: 14
                font.family: "微软雅黑"
                color: "white"
                smooth: true
            }

            Text {
                id: numText
                text: num + " 份"
                anchors.left: priceText.right; anchors.bottom: parent.bottom
                font.pixelSize: 14
                font.family: "微软雅黑"
                color: "white"
                smooth: true
            }
        }
    }

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
}


