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
        interval: 350; running: false; repeat: true
        onTriggered: {
            loadStart()
        }
    }

    Rectangle {
        id: view
        width: parent.width * 0.8; height: parent.height * 0.8
        visible: true
        x: 102
        anchors.verticalCenter: parent.verticalCenter
        transform: Rotation { id:rotation; origin.x: parent.width * 0.8; origin.y: parent.height * 0.8 * 0.5 + 100; axis { x: 0; y: 1; z: 0 } angle: -70 }
        smooth: true
        property string state: "back"

        Image {
            id: viewback
            source: "qrc:/images/store.png"
            anchors.fill: parent
            smooth: true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                view.state = "gone"
                timer2.running = true
            }
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
