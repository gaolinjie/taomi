import QtQuick 1.0
import "../js/global.js" as Global

Item {
    id: rect
    width: parent.width
    height: parent.height
    clip: true

    Component.onCompleted: {
        timer2.running = true
    }

    property string iconSource: ""
    property string iconTitle: ""

    MouseArea{
        anchors.fill: parent
        onClicked: {
            Global.cid = cid
            Global.rectColor = rectColor
            Global.hotColor = hotColor
            Global.title = title
            loadRect(slotQml)
        }
    }

    Image {
        id: imageNow
        source: image
        sourceSize.width: parent.width
        sourceSize.height: parent.height
        Behavior on y {
            NumberAnimation { duration: 1000; easing.type: Easing.OutQuint}
        }
    }

    Image {
        id: imageNext
        y: imageNow.height
        source: image
        sourceSize.width: parent.width
        sourceSize.height: parent.height
        Behavior on y {
            NumberAnimation { duration: 1000; easing.type: Easing.OutQuint}
        }
    }

    Timer {
        id: timer2
        interval: refreshManager.getRandom()
        repeat: true
        onTriggered: {
            if (imageNow.y == 0) {
                imageNext.visible = true
                imageNow.y = -imageNow.height;
                imageNext.y = 0
                timer.running = true
            }
            else {
                imageNow.visible = true
                imageNext.y = -imageNow.height
                imageNow.y = 0
                timer.running = true
            }
            timer2.interval = refreshManager.getRandom();
        }
    }

    Timer {
        id: timer
        interval: 1000
        onTriggered: {
            var img = refreshManager.getImageNext(cid);
            if (img != "") {
                if (imageNext.y == 0) {
                    imageNow.visible = false
                    imageNow.y = imageNow.height
                    imageNow.source = img
                }
                else {
                    imageNext.visible = false
                    imageNext.y = imageNow.height
                    imageNext.source = img
                }
            }
        }
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
        x: 40
        anchors.verticalCenter: titleRect.verticalCenter
        text: parent.iconTitle
        font.pixelSize: 20
        color: "white"
    }
}
