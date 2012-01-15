import QtQuick 1.0
import "../js/global.js" as Global

Item {
    id: itemsScreen
    width: 1024
    height: 600
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
        width: parent.width * 0.8; height: parent.height * 0.8
        color: Global.rectColor
        anchors.verticalCenter: parent.verticalCenter
        transform: Rotation { id: viewRotation; origin.x: parent.width * 0.8; origin.y: parent.height * 0.8 * 0.5 + 100; axis { x: 0; y: 1; z: 0 } angle: -70 }
        smooth: true
        property string state: "back"

        Text {
            id: viewTitle
            x: 125; y: 40
            text: "购物车"
            font.pixelSize: 40
            color: "white"
        }

        Image {
            id: backButton
            source: "qrc:/images/back.png"
            x: 35; y: 41
            sourceSize.width: 44
            sourceSize.height: 44

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    itemsView.state = "gone"
                    timer.running = true
                }
            }
        }

        GridView {
            id: shopcarView
            x:130
            y:120
            model: ShopcarModel{}
            delegate: ShopcarViewDelegate{}
            cacheBuffer: 100
            cellWidth: 241
            cellHeight: 190
            width: 800
            height: 390
            flow: GridView.TopToBottom

        }

        Rectangle {
            id: sendButton
            x: 130; y: 525
            width: 79; height: 27
            color: Global.rectColor
            border.color: "white"
            border.width: 2

            Text {
                text: "发 送"
                anchors.centerIn: parent
                color: "white"
            }

            MouseArea {
                anchors.fill: parent
                onPressed: {
                    sendButton.color = Global.hotColor
                }
                onClicked: {                
                }
                onReleased: {
                    sendButton.color = Global.rectColor
                }               
            }
        }

        states: [
            State {
                name: "back"
                PropertyChanges { target: viewRotation; angle: 0; origin.x: parent.width; origin.y: parent.height * 0.5 +100}
                PropertyChanges { target: itemsView; width: 1024; height: 600; x: 0}
                when: itemsView.state == "back"
            },

            State {
                name: "gone"
                PropertyChanges { target: itemsView; x: -1024; width: 1024 * 0.9; height: 600 * 0.9}
                PropertyChanges { target: viewRotation; angle: 0}
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
