import QtQuick 1.0

Item {
    id: start
    width: 1024
    height: 600
    signal loadStart

    Image {
        id: background
        source: "qrc:/images/background.png"
    }

    Timer {
        id: timer2
        interval: 350; running: false
        onTriggered: {
            loadStart()
        }
    }

    Rectangle {
        id: view
        width: parent.width * 0.8; height: parent.height * 0.8
        color: "#de9317"
        anchors.verticalCenter: parent.verticalCenter
        transform: Rotation { id:rotation; origin.x: parent.width * 0.8; origin.y: parent.height * 0.8 * 0.5 + 100; axis { x: 0; y: 1; z: 0 } angle: -70 }
        smooth: true
        property string state: "back"

        Text {
            id: startText
            x: 130; y: 40
            text: "特 色"
            font.pixelSize: 40
            color: "white"
        }

        Image {
            id: backIcon
            source: "qrc:/images/back.png"
            x: 35; y: 38
            sourceSize.width: 48
            sourceSize.height: 48

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    view.state = "gone"
                    timer2.running = true
                }
            }
        }

        ListView {
            id: listView
            x: 70; y: 120; width: 800; height:600
            model: ItemsModel{}
            delegate: ItemsDelegate{}
            orientation: ListView.Horizontal
            cacheBuffer: 1000
            spacing: 6
            smooth: true
            section.property: "columnCategory"
            section.criteria: ViewSection.FullString
            section.delegate: startSpace
        }

        Component {
            id: startSpace
            Item {
                width: 60
                height: 10
            }
        }

        Text {
            id: selectedText
            text: "选中："
            x: 130; y: 460
            font.pixelSize: 20
            color: "white"
        }

        states: [
            State {
                name: "back"
                PropertyChanges { target: rotation; angle: 0; origin.x: parent.width; origin.y: parent.height * 0.5 +100}
                PropertyChanges { target: view; width: 1024; height: 600; x: 0}
                when: view.state == "back"
            },

            State {
                name: "gone"
                PropertyChanges { target: view; x: -1024}
                PropertyChanges { target: rotation; angle: 0}
                PropertyChanges { target: view; width: 1024 * 0.9; height: 600 * 0.9}
                when: view.state == "gone"
            }

        ]

        transitions: [
            Transition {
                from: ''; to: 'back'
                NumberAnimation { target: rotation; property: "angle"; duration: 500; easing.type: 'OutExpo'}
                NumberAnimation { target: view; properties: 'width, height'; duration: 500; easing.type: 'OutExpo'}
            },

            Transition {
                from: 'back'; to: 'gone'
                SequentialAnimation {
                         NumberAnimation { target: view; properties: 'width, height'; duration: 200}
                         NumberAnimation { target: view; properties: 'x'; duration: 200}
                }
            }
        ]
    }
}
