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
        }
/*
        Rectangle {
            id: nameRect
            width: parent.width; height: 22
            anchors.left: parent.left
            anchors.top: parent.bottom
            color: "#d54d34"

            Text {
                id: nameText
                text: title
                x: 10
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 10
                color: "white"
            }
        }*/
    }
}
