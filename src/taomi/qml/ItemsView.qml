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

        Text {
            id: viewTitle
            anchors.left: parent.left; anchors.top: parent.top
            anchors.leftMargin: 125; anchors.topMargin: 70
            text: Global.title
            font.pixelSize: 50
            color: "white"
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
            anchors.left: viewTitle.left; anchors.leftMargin: 5
            anchors.top: viewTitle.bottom; anchors.topMargin: 35
            font.pixelSize: 20
            color: "white"
        }

        Text {
            id: selectedButton
            text: "已选>"
            anchors.left: allButton.right; anchors.leftMargin: 42
            anchors.verticalCenter: allButton.verticalCenter
            font.pixelSize: 20
            color: "white"
        }

        Text {
            id: shopcarButton
            text: "购物车>"
            anchors.left: selectedButton.right; anchors.leftMargin: 42
            anchors.verticalCenter: selectedButton.verticalCenter
            font.pixelSize: 20
            color: "white"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    shopcarButton.font.bold = true
                    shopcarView.x = 983
                    shopcarButton.color = Global.hotColor
                }
            }
        }

        ListView {
            id: itemsList
            anchors.left: allButton.left; anchors.leftMargin: -60
            anchors.top: allButton.bottom; anchors.topMargin: 50
            width: 1000; height:750
            model: ItemsModel{}
            delegate: ItemsDelegate{}
            orientation: ListView.Horizontal
            cacheBuffer: 100
            spacing: 6
            smooth: true
            section.property: "segment"
            section.criteria: ViewSection.FullString
            section.delegate: listSpace
            property string itemTitle: ""
            property string itemImage: ""
            property string itemDetail: ""
            property real itemPrice: 1.0
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

    Item {
        id: detailView
        anchors.left: parent.left; anchors.leftMargin: 130
        anchors.top: parent.top; anchors.topMargin: 220
        state: itemsList.itemViewState

        Image {
            id: detaiImage
            sourceSize.width: 756; sourceSize.height: 459
            source: itemsList.itemImage
            visible: itemsList.itemVisible
            transform: Rotation {
                id: detailRotation
                origin.x: detaiImage.width * 0.5; origin.y: detaiImage.height * 0.5;
                axis { x: 1; y: 0; z: 0 }
                angle: 90
                Behavior on angle {
                    NumberAnimation { duration: 600; easing.type: Easing.OutQuint}
                }
            }
/*
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
            }*/
        }

        Item {
            id: detailPane
            anchors.left: detaiImage.right; anchors.leftMargin: 50
            anchors.top: detaiImage.top;
            visible: itemsList.itemVisible

            Text {
                id: detailTitle
                text: itemsList.itemTitle
                font.pixelSize: 24
                color: "white"
                Behavior on x {
                    NumberAnimation { duration: 600; easing.type: Easing.OutQuint}
                }
            }

            Text {
                id: priceText
                text: "￥ " + itemsList.itemPrice + " 元 / 例"
                anchors.left: detailTitle.left
                anchors.top: detailTitle.bottom; anchors.topMargin: 10
                font.pixelSize: 18
                color: "white"
                Behavior on x {
                    NumberAnimation { duration: 600; easing.type: Easing.OutQuint}
                }
            }

            Rectangle {
                id: detailArea
                width: 200; height: 345
                anchors.left: priceText.left
                anchors.top: priceText.bottom; anchors.topMargin: 10
                color: Global.rectColor

                Flickable {
                    id: flickArea
                    anchors.fill: parent
                    contentWidth: detailText.width; contentHeight: detailText.height
                    flickableDirection: Flickable.VerticalFlick
                    clip: true

                    TextEdit {
                        id: detailText
                        wrapMode: TextEdit.Wrap
                        width: detailArea.width;
                        readOnly:true
                        font.pixelSize: 16
                        color: "white"
                        text: itemsList.itemDetail
                    }
                }

                ScrollBar {
                    id: scroll
                    pageSize: flickArea.height / flickArea.contentHeight
                    position: flickArea.contentY / flickArea.contentHeight
                    anchors.top: flickArea.top
                    anchors.bottom: flickArea.bottom
                    anchors.left: flickArea.right
                    barColor: Global.hotColor
                    width: 6
                    visible: flickArea.contentHeight > flickArea.height
                }
            }

            Rectangle {
                id: selectButton
                anchors.left: detailArea.left; anchors.leftMargin: 3
                anchors.top: detailArea.bottom; anchors.topMargin: 19
                width: 79; height: 27
                color: Global.rectColor
                border.color: "white"
                border.width: 2

                Text {
                    text: "选 择"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: 16
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        selectButton.color = Global.hotColor
                    }
                    onClicked: {
                        if (shopcarList.model.count != 0) {
                            for (var i = 0; i < shopcarList.model.count; i++) {
                                if (shopcarList.model.get(i).name == itemsList.itemTitle) {
                                    shopcarList.model.get(i).num++;
                                    return;
                                }
                            }
                            if (i == shopcarList.model.count) {
                                shopcarList.model.append({"name": itemsList.itemTitle,
                                                          "image": itemsList.itemImage,
                                                          "price": itemsList.itemPrice,
                                                          "num": 1});
                            }
                        }
                        else {
                            shopcarList.model.append({"name": itemsList.itemTitle,
                                                      "image": itemsList.itemImage,
                                                      "price": itemsList.itemPrice,
                                                      "num": 1});
                        }
                    }
                    onReleased: {
                        selectButton.color = Global.rectColor
                    }
                }
            }

            Rectangle {
                id: returnButton
                anchors.left: selectButton.right; anchors.leftMargin: 25
                anchors.top: selectButton.top
                width: 79; height: 27
                color: Global.rectColor
                border.color: "white"
                border.width: 2

                Text {
                    text: "返 回"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: 16
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        returnButton.color = Global.hotColor
                    }
                    onClicked: {
                        itemsList.visible = true
                        itemsList.itemVisible = false
                        itemsList.itemViewState= "before"
                    }
                    onReleased: {
                        returnButton.color = Global.rectColor
                    }
                }
            }
        }

        states: [
            State {
                name: 'before'
                PropertyChanges { target: detailRotation; origin.x: detaiImage.width*0.5; origin.y: detaiImage.height * 0.5; axis { x: 1; y: 0; z: 0 } angle: 90}

            },
            State {
                name: 'after'
                PropertyChanges { target: detailRotation; angle: 0}
            }
        ]
    }

    Rectangle {
        id: shopcarView
        width: 300; x: 1283
        anchors.top: parent.top; anchors.bottom: parent.bottom
        color: Global.hotColor
        z: 2

        Behavior on x {
            NumberAnimation { duration: 300; easing.type: Easing.OutQuint}
        }

        Rectangle {
            width: 300; height: 100
            color: Global.hotColor
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
            delegate: ShopcarListDelegate{}
            cacheBuffer: 1000
            spacing: 25
            smooth: true
        }

        Rectangle {
            width: 300; height: 80
            color: Global.hotColor
            z: 2
            anchors.bottom: parent.bottom

            Rectangle {
                id: sendButton
                x: 31; y: 30
                width: 79; height: 27
                color: Global.hotColor
                border.color: "white"
                border.width: 2

                Text {
                    text: "管 理"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: 16
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        sendButton.color = Global.rectColor
                    }
                    onClicked: {
                        saveItemsData()
                        loadRect("ShopcarView.qml")
                    }
                    onReleased: {
                        sendButton.color = Global.hotColor
                    }

                    function saveItemsData() {
                        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
                        db.transaction(
                            function(tx) {
                                tx.executeSql('DROP TABLE shopcarData');
                                tx.executeSql('CREATE TABLE IF NOT EXISTS shopcarData(name TEXT, image TEXT, price MONEY, num INTEGER)');
                                var index = 0;
                                while (index < shopcarList.model.count) {
                                    var item = shopcarList.model.get(index);
                                    tx.executeSql('INSERT INTO shopcarData VALUES(?,?,?,?)', [item.name, item.image, item.price, item.num]);
                                    index++;
                                }
                            }
                        )
                    }
                }
            }

            Rectangle {
                id: returnButto
                x: 139; y: 30
                width: 79; height: 27
                color: Global.hotColor
                border.color: "white"
                border.width: 2

                Text {
                    text: "返 回"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: 16
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        returnButto.color = Global.rectColor
                    }
                    onClicked: {
                        shopcarView.x = 1283
                        shopcarButton.color = "white"
                    }
                    onReleased: {
                        returnButto.color = Global.hotColor
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
