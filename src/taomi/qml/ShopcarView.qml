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

                    while(listView.model.count > 3) {
                        listView.model.remove(listView.model.count - 1)
                    }
                }
            }
        }
/*
        Text {
            id: allButton
            text: "所有>"
            x: 130; y: 110
            font.pixelSize: 16
            color: "white"
        }

        Text {
            id: selectedButton
            text: "已选>"
            x: 220; y: 110
            font.pixelSize: 16
            color: "white"
        }

        Text {
            id: shopcarButton
            text: "购物车>"
            x: 310; y: 110
            font.pixelSize: 16
            color: "white"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    shopcarButton.font.bold = true
                    shopcarView.x = 724
                    shopcarButton.color = Global.hotColor
                }
            }
        }*/
/*
        ListView {
            id: listView
            x: 70; y: 160; width: 800; height:600
            model: ItemsModel{}
            delegate: ItemsDelegate{}
            orientation: ListView.Horizontal
            cacheBuffer: 1000
            spacing: 6
            smooth: true
            section.property: "segment"
            section.criteria: ViewSection.FullString
            section.delegate: listSpace
        }

        Component {
            id: listSpace
            Item {
                width: 60
                height: 10
            }
        }*/

        GridView {
            id: shopcarView
            x:130
            y:130
            model: ShopcarModel{}
            delegate: ShopcarViewDelegate{}
            cacheBuffer: 100
            cellWidth: 241
            cellHeight: 190
            width: 800
            height: 390
            flow: GridView.TopToBottom

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
