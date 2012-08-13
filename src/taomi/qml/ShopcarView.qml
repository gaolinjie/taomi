import QtQuick 1.0
import "../js/global.js" as Global

Item {
    id: itemsScreen
    width: 1280; height: 800
    signal loadStart()
    signal loadRect(string qmlFile)

    Connections {
        id: orderManagerConnection
        target: orderManager
        onClearShopcar: {
            unsentView.model.clear()
            sentView.model.clear()
        }
    }

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
            font.family: "微软雅黑"
            color: "white"
            smooth: true
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
            id: unsendedButton
            text: "未发送的菜单◢"
            anchors.left: viewTitle.left; anchors.leftMargin: 5
            anchors.top: viewTitle.bottom; anchors.topMargin: 35
            font.pixelSize: 20
            font.family: "微软雅黑"
            color: "white"
            smooth: true
        }

        UnsentView {
            id: unsentView
            anchors.left: viewTitle.left; anchors.leftMargin: 3
            anchors.top: viewTitle.bottom; anchors.topMargin: 70
        }

        Rectangle {
            id: sendButton
            anchors.left: unsentView.left; anchors.leftMargin: 6
            anchors.top: unsentView.bottom; anchors.topMargin: 5
            width: 79; height: 27
            color: orderManager.isHaveNewOrder() ? Global.rectColor : "grey"
            border.color: "white"
            border.width: 2

            Text {
                text: "发 送"
                anchors.centerIn: parent
                color: "white"
                font.pixelSize: 16
                font.family: "微软雅黑"
                smooth: true
            }

            MouseArea {
                anchors.fill: parent
                onPressed: {
                    if (orderManager.isHaveNewOrder())
                    {
                        sendButton.color = Global.hotColor;
                    }
                }
                onClicked: {
                    if (client.getSeatID() == "")
                    {
                        foreground.visible = true;
                        dialogAlert.visible = true;
                        dialogAlert.content = "  您还未选择座位，请先选择座位再试！";
                        dialogAlert.y = 275;
                        return;
                    }

                    if (orderManager.isHaveNewOrder())
                    {                        
                        if (deviceManager.isRegistered()) {
                            foreground.visible = true;
                            dialogSend.visible = true;
                            dialogAlert.content = "  服务器未能连接，请稍后再试！";
                            dialogSend.y = 275;
                            sendButton.color = "grey";
                        }
                        else {
                            foreground.visible = true;
                            dialogAlert.visible = true;
                            dialogAlert.y = 275;
                            deviceManager.registerDevice();
                        }
                    }
                }
                onReleased: {
                    if (orderManager.isHaveNewOrder())
                    {
                        sendButton.color = Global.rectColor;
                    }
                }               
            }
        }

        Text {
            id: sendedButton
            text: "已发送的菜单◢"
            anchors.left: unsendedButton.left
            anchors.top: sendButton.bottom; anchors.topMargin: 50
            font.pixelSize: 20
            font.family: "微软雅黑"
            color: "white"
            smooth: true
        }

        SentView {
            id: sentView
            anchors.left: unsentView.left
            anchors.top: sendedButton.bottom; anchors.topMargin: 15
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
                refreshUi();
                timer2.running = true;
            }

            Timer {
                id: timer2
                interval: 300
                running: false
                onTriggered: {
                    orderManager.sendOrder();
                }
            }

            onCancel: {
                dialogSend.y = 800
                foreground.visible = false
            }

            function refreshUi() {
                var i = 0;
                var j = 0;
                for (i = 0; i < unsentView.model.count; i++) {
                    var unsent = unsentView.model.get(i);
                    for (j = 0; j < sentView.model.count; j++) {
                        var sent = sentView.model.get(j);
                        if (unsent.name == sent.name) {
                            sentView.model.setProperty(j, "num", Number(unsent.num) + Number(sent.num));
                            break;
                        }
                    }

                    if (j == sentView.model.count) {
                        unsent.sent = 1;
                        sentView.model.append(unsent);
                    }
                }
                unsentView.model.clear();
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
