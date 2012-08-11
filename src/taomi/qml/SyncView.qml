import QtQuick 1.0
import "../js/global.js" as Global

Item {
    id: itemsScreen
    width: 1280; height: 800
    signal loadStart()

    Component.onCompleted: {
        timer3.running = true;
    }

    Connections{
        target: server
        onHaveSynced: {
            okButton.visible = false;
            cancelButton.visible = false;
            returnButton.visible = true;
            busyIndicator.visible = false;
            dialogContent.text = "菜单数据已同步";

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

    Timer {
        id: timer3
        interval: 600
        running: false
        onTriggered: {
            foreground.visible = true;
            dialog.visible = true;
            dialog.y = 275;
            okButton.visible = false;
            cancelButton.visible = false;
            busyIndicator.visible = true;
            dialogContent.text = "正在同步菜单数据, 请稍候...";
            client.startSync();
        }
    }

    Rectangle {
        id: mainView
        width: parent.width; height: parent.height
        color: "#9061C2"
        anchors.verticalCenter: parent.verticalCenter
        transform: Rotation { id: viewRotation; origin.x: parent.width * 0.8; origin.y: parent.height * 0.8 * 0.5 + 100; axis { x: 0; y: 1; z: 0 } angle: -70 }
        smooth: true
        property string state: "back"

        Text {
            id: viewTitle
            anchors.left: parent.left; anchors.top: parent.top
            anchors.leftMargin: 125; anchors.topMargin: 70
            text: "同步"
            font.pixelSize: 50
            color: "white"
            font.family: "微软雅黑"
            smooth: true
        }

        Image {
            id: backButton
            anchors.right: viewTitle.left; anchors.rightMargin: 46
            anchors.verticalCenter: viewTitle.verticalCenter
            sourceSize.width: 50; sourceSize.height: 50
            source: "qrc:/images/back.png"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    mainView.state = "gone"
                    timer.running = true
                }
            }
        }

        Rectangle {
            id: foreground
            width: 1280; height: 800
            anchors.centerIn: parent
            color: "black"
            opacity: 0.7
            visible: false
        }

        Rectangle {
            id: dialog
            y: 800
            width: 1280; height: 250
            color: "#d54d34"
            visible: false

            Behavior on y {
                NumberAnimation { duration: 400; easing.type: Easing.OutQuint}
            }

            Text {
                id: dialogContent
                text: ""
                color: "white"
                font.pixelSize: 28
                font.family: "微软雅黑"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top; anchors.topMargin: 70
            }

            BusyIndicator {
                id: busyIndicator
                anchors.horizontalCenter: dialogContent.horizontalCenter
                anchors.top: dialogContent.bottom; anchors.topMargin: 40
                visible: false
            }

            Rectangle {
                id: okButton
                anchors.right: parent.horizontalCenter; anchors.rightMargin: 20
                anchors.bottom: parent.bottom; anchors.bottomMargin: 70
                width: 79; height: 27
                color: "#d54d34"
                border.color: "white"
                border.width: 2

                Text {
                    text: "确 定"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: 16
                    font.family: "微软雅黑"
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        okButton.color = "#DE4209"
                    }
                    onClicked: {
                        //dialog.y = 800;
                        //foreground.visible = false;
                        //client.syncMenu("192.168.1.106");
                        syncManager.syncMenu();
                        okButton.visible = false;
                        cancelButton.visible = false;
                        busyIndicator.visible = true;
                        dialogContent.text = "正 在 同 步 菜 单 数 据, 请 稍 候...";
                        timer2.running = true;
                    }
                    onReleased: {
                        okButton.color = "#d54d34"
                    }
                }
            }

            Rectangle {
                id: cancelButton
                anchors.left: parent.horizontalCenter; anchors.leftMargin: 20
                anchors.bottom: parent.bottom; anchors.bottomMargin: 70
                width: 79; height: 27
                color: "#d54d34"
                border.color: "white"
                border.width: 2

                Text {
                    text: "取 消"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: 16
                    font.family: "微软雅黑"
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        cancelButton.color = "#DE4209"
                    }
                    onClicked: {
                        dialog.y = 800;
                        foreground.visible = false;
                    }
                    onReleased: {
                        cancelButton.color = "#d54d34"
                    }
                }
            }

            Rectangle {
                id: returnButton
                anchors.horizontalCenter: dialogContent.horizontalCenter
                anchors.bottom: parent.bottom; anchors.bottomMargin: 70
                width: 79; height: 27
                color: "#d54d34"
                border.color: "white"
                border.width: 2
                visible: false

                Text {
                    text: "返 回"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: 16
                    font.family: "微软雅黑"
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        cancelButton.color = "#DE4209"
                    }
                    onClicked: {
                        dialog.y = 800;
                        foreground.visible = false;
                    }
                    onReleased: {
                        cancelButton.color = "#d54d34"
                    }
                }
            }
        }

        Timer {
            id: timer2
            interval: 10000
            running: false
            onTriggered: {
                dialogContent.text = "同 步 菜 单 数 据 完 成"
                returnButton.visible = true;
                busyIndicator.visible = false;
            }
        }

        states: [
            State {
                name: "back"
                PropertyChanges { target: viewRotation; angle: 0; origin.x: parent.width; origin.y: parent.height * 0.5 +100}
                PropertyChanges { target: mainView; x: 0}
                when: mainView.state == "back"
            },

            State {
                name: "gone"
                PropertyChanges { target: mainView; x: -1024}
                PropertyChanges { target: viewRotation; angle: 0}
                when: mainView.state == "gone"
            }
        ]

        transitions: [
            Transition {
                from: ''; to: 'back'
                NumberAnimation { target: viewRotation; property: "angle"; duration: 500; easing.type: 'OutExpo'}
                NumberAnimation { target: mainView; properties: 'width, height'; duration: 500; easing.type: 'OutExpo'}
            },
            Transition {
                from: 'back'; to: 'gone'
                SequentialAnimation {
                         NumberAnimation { target: mainView; properties: 'width, height'; duration: 200}
                         NumberAnimation { target: mainView; properties: 'x'; duration: 200}
                }
            }
        ]
    }
}
