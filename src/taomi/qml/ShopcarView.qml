import QtQuick 1.0
import "../js/global.js" as Global

Item {
    id: itemsScreen
    width: 1280; height: 800
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

        Text {
            id: viewTitle
            anchors.left: parent.left; anchors.top: parent.top
            anchors.leftMargin: 125; anchors.topMargin: 70
            text: "购物车"
            font.pixelSize: 50
            color: "white"
        }

        Image {
            id: backButton
            source: "qrc:/images/back.png"
            anchors.right: viewTitle.left; anchors.rightMargin: 46
            anchors.verticalCenter: viewTitle.verticalCenter
            sourceSize.width: 40; sourceSize.height: 40

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
            anchors.left: viewTitle.left; anchors.leftMargin: 3
            anchors.top: viewTitle.bottom; anchors.topMargin: 40
            model: ShopcarModel{}
            delegate: ShopcarViewDelegate{}
            cacheBuffer: 100
            cellWidth: 301
            cellHeight: 223
            width: 1000
            height: 446
            flow: GridView.TopToBottom
        }

        Rectangle {
            id: sendButton
            anchors.left: shopcarView.left; anchors.leftMargin: 1
            anchors.top: shopcarView.bottom; anchors.topMargin: 35
            width: 79; height: 27
            color: Global.rectColor
            border.color: "white"
            border.width: 2

            Text {
                text: "发 送"
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: 16
            }

            MouseArea {
                anchors.fill: parent
                onPressed: {
                    sendButton.color = Global.hotColor
                }
                onClicked: {
                    foreground.visible = true
                    dialog.visible = true
                    dialog.y = 275
                }
                onReleased: {
                    sendButton.color = Global.rectColor
                }               
            }
        }

        Rectangle {
            id: foreground
            width: 1280; height: 800
            anchors.centerIn: parent
            color: Global.rectColor
            opacity: 0.7
            visible: false
        }

        Rectangle {
            id: dialog
            y: 800
            width: 1280; height: 250
            color: Global.hotColor
            visible: false

            Behavior on y {
                NumberAnimation { duration: 400; easing.type: Easing.OutQuint}
            }

            Text {
                id: sendPrompt
                text: "  发送您点的菜单到厨房？"
                color: "white"
                font.pixelSize: 28
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom; anchors.bottomMargin: 140
            }

            Rectangle {
                id: okButton
                anchors.right: dialog.horizontalCenter; anchors.rightMargin: 20
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
                        dialog.y = 800
                        foreground.visible = false
                    }
                    onReleased: {
                        okButton.color = Global.hotColor
                    }
                }
            }

            Rectangle {
                id: cancelButton
                anchors.left: dialog.horizontalCenter; anchors.leftMargin: 20
                anchors.bottom: dialog.bottom; anchors.bottomMargin: 70
                width: 79; height: 27
                color: Global.hotColor
                border.color: "white"
                border.width: 2

                Text {
                    text: "取 消"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: 16
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        cancelButton.color = Global.rectColor
                    }
                    onClicked: {
                        dialog.y = 800
                        foreground.visible = false
                    }
                    onReleased: {
                        cancelButton.color = Global.hotColor
                    }
                }
            }
        }

        states: [
            State {
                name: "back"
                PropertyChanges { target: viewRotation; angle: 0; origin.x: parent.width; origin.y: parent.height * 0.5 +100}
                PropertyChanges { target: itemsView; x: 0}
                when: itemsView.state == "back"
            },

            State {
                name: "gone"
                PropertyChanges { target: itemsView; x: -1024}
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
