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
            id: priceText
            text: "￥ " + listView.itemPrice + " 元/例"
            x: 630; y: 36
            font.pixelSize: 14
            color: "white"
            visible: listView.itemVisible
            Behavior on x {
                NumberAnimation { duration: 600; easing.type: Easing.OutQuint}
            }
        }
/*
        Text {
            id: detailText
            text: "\n
            Made a similar layout like last \n
            time, with a couple of different\n
            panels. Also added some extras \n
            like the clock and the sidebar, \n
            wondering if I should include it\n
            in Omnimo in the next update."
            x: 557; y: 32
            font.pixelSize: 14
            color: "white"
            visible: listView.itemVisible
            Behavior on x {
                NumberAnimation { duration: 600; easing.type: Easing.OutQuint}
            }
        }*/
/*
        Text {
            id: detailText
            width: 100; height: 300
            text: "Made a similar layout like last time, with a couple of different panels. Also added some extras like the clock and the sidebar, wondering if I should include it in Omnimo in the next update."
            x: 557; y: 62
            font.pixelSize: 14
            color: "white"
            visible: listView.itemVisible
            Behavior on x {
                NumberAnimation { duration: 600; easing.type: Easing.OutQuint}
            }
        }*/

        Rectangle {
                id: detail
                width: 200; height: 230
                x: 557; y: 65
                color: Global.rectColor
                visible: listView.itemVisible

                Flickable {
                    id: flickArea
                     anchors.fill: parent
                     contentWidth: detailText.width; contentHeight: detailText.height
                     flickableDirection: Flickable.VerticalFlick
                     clip: true

                     TextEdit{
                         id: detailText
                         wrapMode: TextEdit.Wrap
                         width: detail.width;
                         readOnly:true
                         font.pixelSize: 14
                         color: "white"
                         text:  "        此菜清末民初便享誉中原，素有“奇味”之称。他以大青鱼为主料，取头尾巧施刀工，摆置扒盘两端，鱼肉剁块圆铺在头尾之间。下锅两面煎黄后以冬笋、香菇、葱段为配料，上锅箅高汤旺火扒制，中小火收汁。汁浓鱼透、色泽红亮。食时头酥肉嫩，香味醇厚。民国初年，康有为游学汴京，尝此菜后有“味烹侯鲭”之赞，康君知味，意犹未尽，又书扇面“海内存知己 小弟康有为”赠又一村饭店的灶头黄润生，成一段文人、名厨相交之佳话。糖醋软熘鱼焙面又称熘鱼焙面、鲤鱼焙面，是豫菜的历史名菜。此菜名，首先在鲤鱼，河南得黄河中下游之利，金色鲤鱼，历代珍品。“岂其食鱼、必河之鲤”，此鱼上市，宋代曾有“不惜百金持于归”之语，可见之珍。其二是豫菜的软熘，他以活汁而闻名。所谓活汁，历来两解，一是熘鱼之汁需达到泛出泡花的程度，称作汁要烘活；二是取方言中和、活之谐音，糖、醋、油三物，甜、咸、酸三味，要在高温下，在搅拌中充分融和，各物、各味俱在，但均不出头，你中有我，我中有你；不见油，不见糖，不见醋，甜中透酸，酸中透咸，鱼肉肥嫩爽口而不腻。鱼肉食完而汁不尽，上火回汁，下入精细的焙面，热汁酥面，口感极妙。 "
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
                    width: 8
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
                onClicked: {
                    if (shopcarList.model.count != 0)
                    {
                        for (var i = 0; i < shopcarList.model.count; i++)
                        {
                            if (shopcarList.model.get(i).name == listView.itemTitle)
                            {
                                shopcarList.model.get(i).num++;
                                return;
                            }
                        }
                        if (i == shopcarList.model.count)
                        {
                            shopcarList.model.append({"name": listView.itemTitle,
                                                      "image": listView.itemImage,
                                                      "price": listView.itemPrice,
                                                      "num": 1});
                        }
                    }
                    else
                    {
                        shopcarList.model.append({"name": listView.itemTitle,
                                                  "image": listView.itemImage,
                                                  "price": listView.itemPrice,
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
                PropertyChanges { target: priceText; x: 657}
                PropertyChanges { target: detail; x: 647}
                PropertyChanges { target: detailRotation; origin.x: detaiImage.width*0.5; origin.y: detaiImage.height * 0.5; axis { x: 1; y: 0; z: 0 } angle: 90}

            },
            State {
                name: 'after'
                PropertyChanges { target: detailTitle; x: 610}
                PropertyChanges { target: priceText; x: 610}
                PropertyChanges { target: detail; x: 610}
                PropertyChanges { target: detailRotation; angle: 0}
            }
        ]
    }

    Rectangle {
        id: shopcarView
        width: 300; x: 1034
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
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        returnButto.color = Global.rectColor
                    }
                    onClicked: {
                        shopcarView.x = 1034
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
