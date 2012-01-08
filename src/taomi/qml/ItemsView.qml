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
            text: Global.title
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
            section.property: "segment"
            section.criteria: ViewSection.FullString
            section.delegate: listSpace
            property string itemTitle: ""
            property string itemImage: ""
            property bool itemVisible: false
            property string itemViewState: "before"
            property string tag: "itemsScreen.tag"
        }

        Component {
            id: listSpace
            Item {
                width: 60
                height: 10
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

    Item {
        id: detailView
        x: 130; y: 150
        state: listView.itemViewState

        Image {
            id: detaiImage
            sourceSize.width: 560; sourceSize.height: 340
            source: listView.itemImage
            transform: Rotation {
                id: detailRotation
                origin.x: detaiImage.width * 0.5; origin.y: detaiImage.height * 0.5;
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
            id: detailTitle
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
            id: detailText
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
            id: selectButton
            x: 617; y: 312
            width: 79; height: 27
            color: Global.rectColor
            border.color: "white"
            border.width: 2
            visible: listView.itemVisible

            Text {
                text: "选 择"
                anchors.centerIn: parent
                color: "white"
            }

            MouseArea {
                anchors.fill: parent
                onPressed: {
                    selectButton.color = Global.hotColor
                }
                onReleased: {
                    selectButton.color = Global.rectColor
                }
            }
        }

        Rectangle {
            id: returnButton
            x: 720; y: 312
            width: 79; height: 27
            color: Global.rectColor
            border.color: "white"
            border.width: 2
            visible: listView.itemVisible

            Text {
                text: "返 回"
                anchors.centerIn: parent
                color: "white"
            }

            MouseArea {
                anchors.fill: parent
                onPressed: {
                    returnButton.color = Global.hotColor
                }
                onClicked: {
                    listView.visible = true
                    listView.itemVisible = false
                    listView.itemViewState= "before"
                }
                onReleased: {
                    returnButton.color = Global.rectColor
                }
            }
        }       

        states: [
            State {
                name: 'before'
                PropertyChanges { target: detailTitle; x: 650}
                PropertyChanges { target: detailText; x: 617}
                PropertyChanges { target: detailRotation; origin.x: detaiImage.width*0.5; origin.y: detaiImage.height * 0.5; axis { x: 1; y: 0; z: 0 } angle: 90}

            },
            State {
                name: 'after'
                PropertyChanges { target: detailTitle; x: 610}
                PropertyChanges { target: detailText; x: 577}
                PropertyChanges { target: detailRotation; angle: 0}
            }
        ]
    }

    Rectangle {
        id: shopcarView
        width: 300; x: 1034
        anchors.top: parent.top; anchors.bottom: parent.bottom
        color: "#d54d34"
        z: 2

        Behavior on x {
            NumberAnimation { duration: 300; easing.type: Easing.OutQuint}
        }

        Rectangle {
            width: 300; height: 100
            color: "#d54d34"
            z: 2

            Text {
                x: 28; y: 40
                text: "购物车"
                font.pixelSize: 38
                color: "white"
            }
        }

        ListView {
            id: shopcarList
            x: 30; y: 110; width: 200; height:400
            model: ShopcarModel{}
            delegate: ShopcarDelegate{}
            cacheBuffer: 1000
            spacing: 25
            smooth: true
 //           section.property: "columnCategory"
  //          section.criteria: ViewSection.FullString
   //         section.delegate: listSpace
        }

        Rectangle {
            width: 300; height: 80
            color: "#d54d34"
            z: 2
            anchors.bottom: parent.bottom

            Rectangle {
                id: sendButton
                x: 31; y: 30
                width: 79; height: 27
                color: "#d54d34"
                border.color: "white"
                border.width: 2

                Text {
                    text: "管 理"
                    anchors.centerIn: parent
                    color: "white"
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        sendButton.color = "#de9317"
                    }
                    onClicked: {
                        loadRect("rect.qml")
                    }
                    onReleased: {
                        sendButton.color = "#d54d34"
                    }
                }
            }

            Rectangle {
                id: returnButto
                x: 139; y: 30
                width: 79; height: 27
                color: "#d54d34"
                border.color: "white"
                border.width: 2

                Text {
                    text: "返 回"
                    anchors.centerIn: parent
                    color: "white"
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        returnButto.color = "#de9317"
                    }
                    onClicked: {
                        shopcarView.x = 1034
                        shopcarButton.color = "white"
                    }
                    onReleased: {
                        returnButto.color = "#d54d34"
                    }
                }
            }
        }
    }

    BorderImage {
        anchors.fill: shopcarView
        anchors { leftMargin: -9; topMargin: -6; rightMargin: -8; bottomMargin: -8 }
        border { left: 10; top: 10; right: 10; bottom: 10 }
        source: "qrc:/images/shadow.png";
        smooth: true
        z: 1
    }
}
