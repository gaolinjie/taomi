import QtQuick 1.0

Rectangle {
    id: rect
    width: parent.width
    height: parent.height
    color: rectColor
    state: columnState

    property string iconSource: ""
    property string iconTitle: ""

    MouseArea{
        anchors.fill: parent
        onClicked: loadRect(slotQml)
    }

    Image {
        id: icon
        x: 20
        anchors.verticalCenter: parent.verticalCenter
        source: parent.iconSource
        sourceSize.width: 90
        sourceSize.height: 90
    }

    Text {
        id: text
        x: 120
        anchors.verticalCenter: parent.verticalCenter
        text: parent.iconTitle
        font.pixelSize: 28
        color: "white"



    }
}
