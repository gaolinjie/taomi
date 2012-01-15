import QtQuick 1.0
import "../js/global.js" as Global

Component {
    id: shopcarViewDelegate

    Item {
        id: itemRect
        width: 235
        height: 184

        Rectangle {
            id: nameRect
            width: parent.width; height: 32
            anchors.left: parent.left
            anchors.bottom: itemImage.top
            color: Global.hotColor

            Text {
                id: nameText
                text: name
                anchors.left: parent.left; anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                color: "white"
            }

            Text {
                id: priceText
                text: "￥ " + price + " 元"
                anchors.right: parent.right; anchors.rightMargin: 5
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                color: "white"
            }
        }

        Image {
            id: itemImage
            source: image
            sourceSize.width: 235
            sourceSize.height: 120
            anchors.verticalCenter: parent.verticalCenter

            Rectangle {
                width: 32; height: 32
                anchors.right: parent.right
                anchors.top: parent.top
                color: Global.hotColor

                Text {
                    text: num + "份"
                    x: 10
                    anchors.centerIn: parent
                    font.pixelSize: 14
                    color: "white"
                }
            }
        }

        Rectangle {
            id: controlRect
            width: parent.width; height: 32
            anchors.left: parent.left
            anchors.top: itemImage.bottom
            color: Global.hotColor

            Image {
                id: addIcon
                source: "qrc:/images/add.png"
                sourceSize.width: 24; sourceSize.height: 24
                anchors.verticalCenter: parent.verticalCenter
                x: 75

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        itemRect.parent.parent.model.get(index).num++
                    }
                }
            }

            Image {
                id: minusIcon
                source: "qrc:/images/minus.png"
                sourceSize.width: 24; sourceSize.height: 24
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        if (itemRect.parent.parent.model.get(index).num > 1) {
                            itemRect.parent.parent.model.get(index).num--
                        }
                    }
                }
            }

            Image {
                id: closeIcon
                source: "qrc:/images/close.png"
                sourceSize.width: 24; sourceSize.height: 24
                anchors.verticalCenter: parent.verticalCenter
                x: 136



                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        removeItem()
                    }

                    function removeItem() {
                        var i = 0;
                        while (itemRect.parent.parent.model.get(i).name != name) {
                            i++;
                        }
                        itemRect.parent.parent.model.remove(i);
                    }
                }
            }
        }
    }
}
