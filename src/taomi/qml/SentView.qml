import QtQuick 1.0
import "../js/global.js" as Global

GridView {
    id: sentView
    model: sentModel
    delegate: sentDelegate
    cacheBuffer: 100
    cellWidth: 465
    cellHeight: 80
    width: 1000
    height: 180
    flow: GridView.TopToBottom

    Component {
        id: sentDelegate

        Item {
            id: itemRect
            width: 465
            height: 80
            property real number: num

            Image {
                id: itemImage
                source: image
                sourceSize.width: 100
                sourceSize.height: 70
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left; anchors.leftMargin: 5
                smooth: true
            }

            Rectangle {
                id: nameRect
                width: 350; height: 70
                anchors.left: itemImage.right; anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                color: Global.hotColor

                Text {
                    id: nameText
                    text: name
                    anchors.left: parent.left; anchors.leftMargin: 10
                    anchors.top: parent.top; anchors.topMargin: 10
                    font.pixelSize: 20
                    color: "white"
                }

                Text {
                    id: priceText
                    text: "￥ " + price + " 元"
                    anchors.left: nameText.left
                    anchors.top: nameText.bottom; anchors.topMargin: 10
                    font.pixelSize: 16
                    color: "white"
                }

                Text {
                    text: "x " + num + "份"
                    anchors.left: priceText.right; anchors.leftMargin: 10
                    anchors.top: priceText.top
                    font.pixelSize: 16
                    color: "white"
                }
            }
        }
    }

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
}
