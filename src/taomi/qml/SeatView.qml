import QtQuick 1.0
import "../js/global.js" as Global

Item {
    id: itemsScreen
    width: 1280; height: 800
    signal loadStart()
    clip: true

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
        interval: 10
        running: false
        onTriggered: {
            var index = 0;
            while (index < seatCategory.model.count) {
                if (seatCategory.model.get(index).active == 1) {
                    Global.seatType = seatCategory.model.get(index).scid;
                }
                index++;
            }

            seatView.source = "qrc:/qml/SeatGrid.qml"
        }
    }

    Connections {
        target: seatCategory
        onChangeSeatType: {
            //console.log("SeatView" + Global.seatType)
            seatView.source = "";
            timer3.running = true;
        }
    }

    Rectangle {
        id: mainView
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
            text: Global.title
            font.pixelSize: 50
            font.family: "微软雅黑"
            smooth: true
            color: "white"
        }

        Image {
            id: backButton
            source: "qrc:/images/back.png"
            anchors.right: viewTitle.left; anchors.rightMargin: 46
            anchors.verticalCenter: viewTitle.verticalCenter
            sourceSize.width: 50; sourceSize.height: 50

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    mainView.state = "gone"
                    timer.running = true
                }
            }
        }
/*
        Rectangle {
             id: addSeatRect
             width: 100; height: 40
             color: "#de9317"
             anchors.left: viewTitle.left
             anchors.top: viewTitle.bottom; anchors.topMargin: 40

             Text {
                 text: ""
                 anchors.centerIn: parent
                 color: "white"//active == 1 ? "white" : "black"
                 font.pixelSize: 16
                 font.family: "微软雅黑"
                 smooth: true
             }

             Image {
                 id: addSeatTypeImage
                 source: "qrc:/images/add.png"
                 sourceSize.width: 28
                 sourceSize.height: 28
                 anchors.centerIn: parent
             }

             MouseArea {
                 anchors.fill: parent
                 onPressed: {
                     addSeatRect.color = "#5859b9";
                 }
                 onClicked: {
                 }
                 onReleased: {
                     addSeatRect.color = "#de9317";
                     addSeatPanel.visible = true;
                     addSeatPanel.x = 880;
                     //addSeatPanel.state = "newtype"
                 }
             }
        }*/

        SeatCategory {
            id: seatCategory
            anchors.left: viewTitle.left
            anchors.top: viewTitle.bottom; anchors.topMargin: 40
        }

        Loader {
            id: seatView
            anchors.left: seatCategory.left
            anchors.top: seatCategory.bottom; anchors.topMargin: 50
            source: ""
            property ListModel contentModel: ListModel{}
            Component.onCompleted: {
                timer3.running = true;
            }
        }
/*
        AddSeatPanel {
            id: addSeatPanel
            x: parent.width//parent.width - addPanel.width
            visible: false
            Behavior on x {
                NumberAnimation { duration: 600; easing.type: Easing.OutQuint}
            }
        }

        Rectangle {
            id: foreground
            width: 1280; height: 800
            anchors.centerIn: parent
            color: Global.rectColor
            opacity: 0.7
            visible: false
        }*/

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
