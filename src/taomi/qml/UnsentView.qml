import QtQuick 1.0
import "../js/global.js" as Global

GridView {
    id: unsentView
    model: unsentModel
    delegate: unsentDelegate
    cacheBuffer: 100
    cellWidth: 465
    cellHeight: 80
    width: 1000
    height: 180
    flow: GridView.TopToBottom

    Component {
        id: unsentDelegate

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

                Image {
                    id: addIcon
                    source: "qrc:/images/add.png"
                    sourceSize.width: 32; sourceSize.height: 32
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: minusIcon.left; anchors.rightMargin: 10

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            itemRect.parent.parent.model.setProperty(index, "num", number+1);
                        }
                    }
                }

                Image {
                    id: minusIcon
                    source: "qrc:/images/minus.png"
                    sourceSize.width: 32; sourceSize.height: 32
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: closeIcon.left; anchors.rightMargin: 10

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (itemRect.parent.parent.model.get(index).num > 1) {
                                itemRect.parent.parent.model.setProperty(index, "num", number-1);
                            }
                        }
                    }
                }

                Image {
                    id: closeIcon
                    source: "qrc:/images/close.png"
                    sourceSize.width: 32; sourceSize.height: 32
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right; anchors.rightMargin: 10

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            itemRect.parent.parent.model.remove(index);
                        }
                    }
                }
            }
        }
    }

    ListModel {
        id: unsentModel
        Component.onCompleted: loadItemsData()
        Component.onDestruction: saveItemsData()
        function loadItemsData() {
            var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
            db.transaction(
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS unsentModel(orderNO INTEGER key, name TEXT, image TEXT, price REAL, num INTEGER, sent INTEGER)');
                    var rs = tx.executeSql('SELECT * FROM unsentModel');
                    var index = 0;
                    if (rs.rows.length > 0) {
                        while (index < rs.rows.length) {
                            var item = rs.rows.item(index);
                            unsentModel.append({"orderNO": item.orderNO,
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
                    tx.executeSql('DROP TABLE unsentModel');
                    tx.executeSql('CREATE TABLE IF NOT EXISTS unsentModel(orderNO INTEGER key, name TEXT, image TEXT, price REAL, num INTEGER, sent INTEGER)');
                    var index = 0;
                    while (index < unsentModel.count) {
                        var item = unsentModel.get(index);
                        tx.executeSql('INSERT INTO unsentModel VALUES(?,?,?,?,?,?)', [item.orderNO, item.name, item.image, item.price, item.num, item.sent]);
                        index++;
                    }
                }
            )
        }
    }
}
