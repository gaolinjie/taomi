import QtQuick 1.0

Item {
    id: start
    width: 1280; height: 800

    signal loadRect(string qmlFile)

    Image {
        id: background
        source: "qrc:/images/background.png"
    }

    Text {
        id: startText
        x: 130; y: 70
        text: "菜 单"
        font.family: "Vera Sans YuanTi"
        font.pixelSize: 50
        color: "white"
        opacity: 0

        Behavior on x {
            NumberAnimation {duration: 1000; easing.type: Easing.OutQuint}
        }
        Behavior on opacity {
            NumberAnimation {duration: 1000; easing.type: Easing.OutQuint}
        }
    }

    Timer {
        id: timer
        interval: 1000; running: false; repeat: true
        onTriggered: {
            startText.x = 90
            startText.opacity = 1
        }
    }

    ListView {
        id: listView
        x:550; y:201; width: 1000; height:500
        model: StartModel{}
        delegate: StartDelegate{}
        orientation: ListView.Horizontal
        cacheBuffer: 1000
        spacing: 6
        smooth: true
        section.property: "columnCategory"
        section.criteria: ViewSection.FullString
        section.delegate: startSpace

        Behavior on x {
            NumberAnimation {duration: 1600; easing.type: Easing.OutQuint}
        }
        Behavior on y {
            NumberAnimation {duration: 1000; easing.type: Easing.OutQuint}
        }

        Component.onCompleted: {
            timer.running = true
            listView.x = 30

            for (var i = 0; i < listView.model.count; i++)
            {
                listView.model.get(i).columnState = "active"
            }
        }
    }

    Component {
        id: startSpace
        Item {
            width: 60
            height: 10
        }
    }
}
