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
            x: 125; y: 40
            text: "特 色"
            font.pixelSize: 40
            color: "white"
        }

        Image {
            id: backIcon
            source: "qrc:/images/back.png"
            x: 35; y: 42
            sourceSize.width: 44
            sourceSize.height: 44

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    view.state = "gone"
                    timer2.running = true

                    while(listView.model.count > 3) {
                        listView.model.remove(listView.model.count - 1)
                    }
                }
            }
        }

        Text {
            id: selectedText
            text: "所有>            已选>            购物车>"
            x: 130; y: 110
            font.pixelSize: 16
            color: "white"
        }

        ListView {
            id: listView
            x: 70; y: 160; width: 800; height:600
            model: ItemsModel{}
            delegate: ItemsDelegate{}
            orientation: ListView.Horizontal
            cacheBuffer: 1000
            spacing: 6
            smooth: true
            section.property: "columnCategory"
            section.criteria: ViewSection.FullString
            section.delegate: startSpace
            property string itemTitle: ""
            property string itemImage: ""
            property bool itemVisible: false
            property string itemViewState: "before"
        }

        Component {
            id: startSpace
            Item {
                width: 60
                height: 10
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

    Item {
        id: itemView
//      visible: listView.itemVisible
        x: 130; y: 150
        state: listView.itemViewState

        Image {
            id: image
            sourceSize.width: 560; sourceSize.height: 340
            source:  listView.itemImage
            transform: Rotation {
                id:rotation2;
                origin.x: image.width*0.5; origin.y: image.height * 0.5;
                axis { x: 1; y: 0; z: 0 }
                angle: 90
                Behavior on angle {
                    NumberAnimation { duration: 600; easing.type: Easing.OutQuint}
                }
            }

            Text {
                id: preText
                text: "<"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 40
                color: "white"

                MouseArea {
                    anchors.fill: parent
                    onClicked: {

                    }
                }
            }

            Text {
                id: nextText
                text: ">"
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 40
                color: "white"
            }
        }

        Text {
            id: titleText
            text: listView.itemTitle
            x: 590; y: 0
            font.pixelSize: 22
            color: "white"
            visible: listView.itemVisible
            Behavior on x {
                NumberAnimation { duration: 600; easing.type: Easing.OutQuint}
            }
        }

        Text {
            id: detailsText
            text: "\n
            Made a similar layout like last \n
            time, with a couple of different\n
            panels. Also added some extras \n
            like the clock and the sidebar, \n
            wondering if I should include it\n
            in Omnimo in the next update."
            x: 557; y: 16
            font.pixelSize: 14
            color: "white"
            visible: listView.itemVisible
            Behavior on x {
                NumberAnimation { duration: 600; easing.type: Easing.OutQuint}
            }
        }

        Rectangle {
            id: button
            x: 617; y: 312
            width: 79; height: 27
            color: "#de9317"
            border.color: "white"
            border.width: 2
            visible: listView.itemVisible

            Text {
                id: buttonText
                text: "选 择"
                anchors.centerIn: parent
                color: "white"
            }

            MouseArea {
                anchors.fill: parent
                onPressed: {
                    button.color = "#d54d34"
                }
                onReleased: {
                    button.color = "#de9317"
                }
            }
        }

        Rectangle {
            id: buttonCancel
            x: 720; y: 312
            width: 79; height: 27
            color: "#de9317"
            border.color: "white"
            border.width: 2
            visible: listView.itemVisible

            Text {
                id: cancelbuttonText
                text: "返 回"
                anchors.centerIn: parent
                color: "white"
            }

            MouseArea {
                anchors.fill: parent
                onPressed: {
                    buttonCancel.color = "#d54d34"
                }
                onClicked: {
                    listView.visible = true
                    listView.itemVisible = false
                    listView.itemViewState= "before"
                }
                onReleased: {
                    buttonCancel.color = "#de9317"
                }
            }
        }       

        states: [
            State {
                name: 'before'
                PropertyChanges { target: titleText; x: 650}
                PropertyChanges { target: detailsText; x: 617}
                PropertyChanges { target: rotation2; origin.x: image.width*0.5; origin.y: image.height * 0.5; axis { x: 1; y: 0; z: 0 } angle: 90}

            },
            State {
                name: 'after'
                PropertyChanges { target: titleText; x: 610}
                PropertyChanges { target: detailsText; x: 577}
                PropertyChanges { target: rotation2; angle: 0}
            }
        ]
    }
}
