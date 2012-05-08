import QtQuick 1.0
import "../js/global.js" as Global

Rectangle {
    id: rect
    width: parent.width
    height: parent.height
    color: rectColor

    property string iconSource: ""
    property string iconTitle: ""

    MouseArea{
        anchors.fill: parent
        onClicked: {
            Global.rectColor = rectColor
            Global.hotColor = hotColor
            Global.title = title
            loadRect(slotQml)
        }
    }

    Image {
        id: icon
        x: 50
        anchors.verticalCenter: parent.verticalCenter
        source: parent.iconSource
        sourceSize.width: 90
        sourceSize.height: 90
    }

    Text {
        id: text
        x: 150
        anchors.verticalCenter: parent.verticalCenter
        text: parent.iconTitle
        font.pixelSize: 30
        color: "white"
    }
}
