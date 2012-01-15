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
            text: name
            x: 80; anchors.top: parent.top
            font.pixelSize: 16
            color: "white"
        }

        Text {
            id: priceText
            text: "￥ " + price + " 元 x "
            x: 80; anchors.bottom: parent.bottom
            font.pixelSize: 14
            color: "white"
        }

        Text {
            id: numText
            text: num + " 份"
            anchors.left: priceText.right; anchors.bottom: parent.bottom
            font.pixelSize: 14
            color: "white"
        }
    }
}
