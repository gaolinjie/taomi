import QtQuick 1.0

Item {
    id: itemRect
    width: parent.width
    height: parent.height

    property string image: ""
    property string name: ""

    Image {
        id: itemImage
        source: parent.image
        sourceSize.width: parent.width
        sourceSize.height: parent.height
        anchors.fill: parent
    }

    Rectangle {
        id: nameRect
        width: parent.width; height: 32
        anchors.left: parent.left
        anchors.top: parent.bottom
        color: "#d54d34"

        Text {
            id: nameText
            text: itemRect.name
            x: 10
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 14
            color: "white"
        }
    }
}
