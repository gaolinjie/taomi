import QtQuick 1.0
import "../js/global.js" as Global

Item {
    id: rect
    width: parent.width
    height: parent.height
    state: columnState

    property string iconSource: ""
    property string iconTitle: ""

    MouseArea{
        anchors.fill: parent
        onClicked: {
            Global.tag = tag
            Global.rectColor = rectColor
            Global.hotColor = hotColor
            Global.title = title
            loadRect(slotQml)
        }
    }

    Image {
        id: image
        source: parent.iconSource
        sourceSize.width: parent.width
        sourceSize.height: parent.height
        anchors.fill: parent
    }

    Rectangle {
        id: titleRect
        width: parent.width; height: 40
        color: rectColor
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        opacity: 0.8
    }

    Text {
        id: text
        x: 30
        anchors.verticalCenter: titleRect.verticalCenter
        text: parent.iconTitle
        font.pixelSize: 18
        color: "white"
    }
}
