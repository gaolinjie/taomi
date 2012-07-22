import QtQuick 1.0

Item {
    id: screen
    width: 1280; height: 800

    Component.onCompleted: {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
    }

    Loader {
        id: mainLoader
        source: "qrc:/qml/start.qml"
    }

    Connections{
        target: mainLoader.item
        onLoadStart: {mainLoader.source = "qrc:/qml/start.qml"}
        onLoadRect: {mainLoader.source = qmlFile}
    }

    Rectangle {
        id: toast
        width: 460
        height: 120
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        color: "#d54d34"
        smooth: true
        opacity: 0

        Behavior on opacity {
            NumberAnimation { duration: 1000; easing.type: Easing.OutQuint}
        }

        Text {
            id: toastText
            text: "菜单数据已更新"
            color: "white"
            anchors.left: parent.left
            anchors.leftMargin: 30
            anchors.top: parent.top
            anchors.topMargin: 20
            font.pixelSize: 20
            font.family: "微软雅黑"
            font.letterSpacing: 2
        }

        Image {
            id: toastImage
            source: "qrc:/images/Cloud-refresh.png"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20
        }
    }

    Timer {
        id: toastDisappearTimer
        interval: 4000
        running: false
        onTriggered: {
            toast.opacity = 0;
        }
    }

    Connections{
        target: server
        onSync: {
            toast.opacity = 1;
            toastDisappearTimer.running = true;
        }
    }
}
