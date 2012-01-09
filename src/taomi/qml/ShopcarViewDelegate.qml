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
                x: 10
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
            }

            Image {
                id: minusIcon
                source: "qrc:/images/minus.png"
                sourceSize.width: 24; sourceSize.height: 24
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Image {
                id: closeIcon
                source: "qrc:/images/close.png"
                sourceSize.width: 24; sourceSize.height: 24
                anchors.verticalCenter: parent.verticalCenter
                x: 136
            }
        }
    }
}
