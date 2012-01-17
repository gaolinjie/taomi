import QtQuick 1.0
import "../js/global.js" as Global

Component {
    id: shopcarViewDelegate

    Item {
        id: itemRect
        width: 235
        height: 184
        property real number: num

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
            smooth: true

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
                        itemRect.parent.parent.model.setProperty(index, "num", number+1);
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
                            itemRect.parent.parent.model.setProperty(index, "num", number-1);
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
                        itemRect.parent.parent.model.remove(index);
                    }
                }
            }
        }
    }
}
