import QtQuick 1.0

Component {
    id: shopcarDelegate

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
            text: title
            x: 80; anchors.top: parent.top
            font.pixelSize: 16
            color: "white"
        }

        Text {
            id: priceText
            text: "￥ 16.5 元"
            x: 80; anchors.bottom: parent.bottom
            font.pixelSize: 14
            color: "white"
        }

        Text {
            id: numText
            text: " x 1 份"
            anchors.left: priceText.right; anchors.bottom: parent.bottom
            font.pixelSize: 14
            color: "white"
        }
/*
        Image {
            x: 250
            source: "qrc:/images/appbar.new.rest.png"
            sourceSize.width: 40
            sourceSize.height: 40
            anchors.verticalCenter: parent.verticalCenter
        }

        Image {
            x: 280
            source: "qrc:/images/appbar.minus.rest.png"
            sourceSize.width: 40
            sourceSize.height: 40
            anchors.verticalCenter: parent.verticalCenter
        }

        Image {
            x: 310
            source: "qrc:/images/appbar.close.rest.png"
            sourceSize.width: 40
            sourceSize.height: 40
            anchors.verticalCenter: parent.verticalCenter
        }*/
    }
}
