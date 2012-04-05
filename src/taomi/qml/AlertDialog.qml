// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../js/global.js" as Global

Rectangle {
    id: dialog
    y: 800
    width: 1280; height: 250
    color: Global.hotColor
    visible: false

    property string content: ""

    signal ok
    signal cancel

    Behavior on y {
        NumberAnimation { duration: 400; easing.type: Easing.OutQuint}
    }

    Text {
        id: dialogContent
        text: content
        color: "white"
        font.pixelSize: 28
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom; anchors.bottomMargin: 140
    }

    Rectangle {
        id: okButton
        anchors.horizontalCenter: dialog.horizontalCenter
        anchors.bottom: dialog.bottom; anchors.bottomMargin: 70
        width: 79; height: 27
        color: Global.hotColor
        border.color: "white"
        border.width: 2

        Text {
            text: "确 定"
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 16
        }

        MouseArea {
            anchors.fill: parent
            onPressed: {
                okButton.color = Global.rectColor
            }
            onClicked: {
                dialog.ok()
            }
            onReleased: {
                okButton.color = Global.hotColor
            }
        }
    }
}
