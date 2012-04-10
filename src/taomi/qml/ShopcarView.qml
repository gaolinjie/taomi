import QtQuick 1.0
import "../js/global.js" as Global

Item {
    id: itemsScreen
    width: 1280; height: 800
    signal loadStart()
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

        Text {
            id: allButton
            text: "未发送的菜单◢"
            anchors.left: viewTitle.left; anchors.leftMargin: 5
            anchors.top: viewTitle.bottom; anchors.topMargin: 35
            font.pixelSize: 20
            color: "white"
        }

        GridView {
            id: shopcarView
            anchors.left: viewTitle.left; anchors.leftMargin: 3
            anchors.top: viewTitle.bottom; anchors.topMargin: 70
            model: ShopcarModel{}
            delegate: ShopcarViewDelegate{}
            cacheBuffer: 100
            cellWidth: 465
            cellHeight: 80
            width: 1000
            height: 180
            flow: GridView.TopToBottom
        }

        Rectangle {
            id: sendButton
            anchors.left: shopcarView.left; anchors.leftMargin: 6
            anchors.top: shopcarView.bottom; anchors.topMargin: 5
            width: 79; height: 27
            color: orderManager.isHaveNewOrder() ? Global.rectColor : "grey"
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
                    if (orderManager.isHaveNewOrder())
                    {
                        sendButton.color = Global.hotColor
                    }
                }
                onClicked: {
                    if (orderManager.isHaveNewOrder())
                    {
                        if (deviceManager.isRegistered()) {
                            foreground.visible = true
                            dialogSend.visible = true
                            dialogSend.y = 275
                            sendButton.color = "grey"
                        }
                        else {
                            foreground.visible = true
                            dialogAlert.visible = true
                            dialogAlert.y = 275
                            deviceManager.registerDevice()
                        }
                    }
                }
                onReleased: {
                    if (orderManager.isHaveNewOrder())
                    {
                        sendButton.color = Global.rectColor
                    }
                }               
            }
        }

        Text {
            id: selectedButton
            text: "已发送的菜单◢"
            anchors.left: allButton.left
            anchors.top: sendButton.bottom; anchors.topMargin: 50
            font.pixelSize: 20
            color: "white"
        }

        GridView {
            id: shopcarView2
            anchors.left: shopcarView.left
            anchors.top: selectedButton.bottom; anchors.topMargin: 15
            model: ShopcarModel{}
            delegate: SendedViewDelegate{}
            cacheBuffer: 100
            cellWidth: 465
            cellHeight: 80
            width: 1000
            height: 180
            flow: GridView.TopToBottom
        }

        Rectangle {
            id: foreground
            width: 1280; height: 800
            anchors.centerIn: parent
            color: Global.rectColor
            opacity: 0.7
            visible: false
        }

        Dialog {
            id: dialogSend
            content: "  发送您点的菜单到厨房？"

            onOk: {
                dialogSend.y = 800
                foreground.visible = false
                orderManager.sendOrder()
                orderManager.suborderNO = orderManager.suborderNO + 1;
            }

            onCancel: {
                dialogSend.y = 800
                foreground.visible = false
            }
        }

        AlertDialog {
            id: dialogAlert
            content: "  服务器未能连接，请稍后再试！"

            onOk: {
                dialogAlert.y = 800
                foreground.visible = false
            }

            onCancel: {
                dialogAlert.y = 800
                foreground.visible = false
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
