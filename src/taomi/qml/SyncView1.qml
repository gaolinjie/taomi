import QtQuick 1.0
import "../js/global.js" as Global

Item {
    id: itemsScreen
    width: 1280
    height: 800
    signal loadStart
    clip: true

    Rectangle {
        id: itemsView
        width: parent.width; height: parent.height
        color: Global.rectColor
        anchors.verticalCenter: parent.verticalCenter
        smooth: true
        property string state: "back"

        Text {
            id: viewTitle
            anchors.left: parent.left; anchors.top: parent.top
            anchors.leftMargin: 125; anchors.topMargin: 70
            text: "同 步"
            font.pixelSize: 50
            color: "white"
        }
    }
}
