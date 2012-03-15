import QtQuick 1.0
import "../js/global.js" as Global

Item {
    id: itemsScreen
    width: 1280
    height: 800
    signal loadStart
    signal loadRect(string qmlFile)

    Image {
        id: background
        source: "qrc:/images/background.png"
    }

    Timer {
        id: timer
        interval: 350
        running: false
        onTriggered: {
            loadStart()
        }
    }

    Rectangle {
        id: itemsView
        width: parent.width; height: parent.height
        color: Global.rectColor
        anchors.verticalCenter: parent.verticalCenter
        transform: Rotation { id: viewRotation; origin.x: parent.width * 0.8; origin.y: parent.height * 0.8 * 0.5 + 100; axis { x: 0; y: 1; z: 0 } angle: -70 }
        smooth: true
        property string state: "back"

        Image {
            id: itemImage
            source: "qrc:/images/Tagine.jpg"
            width: 900; height: 800
        }


        Image {
            id: backButton
            anchors.left: parent.left; anchors.leftMargin: 29
            anchors.top: parent.top; anchors.topMargin: 60
            sourceSize.width: 50; sourceSize.height: 50
            source: "qrc:/images/back.png"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    itemsView.state = "gone"
                    timer.running = true

                    while(itemsList.model.count > 3) {
                        itemsList.model.remove(itemsList.model.count - 1)
                    }
                }
            }
        }


        states: [
            State {
                name: "back"
                PropertyChanges { target: viewRotation; angle: 0; origin.x: itemsView.width; origin.y: itemsView.height * 0.5 +100}
                PropertyChanges { target: itemsView; x: 0}
                when: itemsView.state == "back"
            },

            State {
                name: "gone"
                PropertyChanges { target: viewRotation; angle: 0}
                PropertyChanges { target: itemsView; x: -1024}
                when: itemsView.state == "gone"
            }
        ]

        transitions: [
            Transition {
                from: ''; to: 'back'
                NumberAnimation { target: viewRotation; property: "angle"; duration: 500; easing.type: 'OutExpo'}
                NumberAnimation { target: itemsView; properties: 'width, height'; duration: 500; easing.type: 'OutExpo'}
            },

            Transition {
                from: 'back'; to: 'gone'
                SequentialAnimation {
                         NumberAnimation { target: itemsView; properties: 'width, height'; duration: 200}
                         NumberAnimation { target: itemsView; properties: 'x'; duration: 200}
                }
            }
        ]
    }
}
