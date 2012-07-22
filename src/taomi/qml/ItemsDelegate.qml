import QtQuick 1.0
import "../js/global.js" as Global

Component {
    id: itemsDelegate

    Item {
        id: wraper
        width: 294; height: 150 * 2 + 38
        signal showItem(string name, string image)

        Column {
            id: col
            //anchors.centerIn: parent
            spacing: 38

            Repeater {
                model: column

                Item {
                    id: itemRect
                    width: 294
                    height: 150

                    Image {
                        id: itemImage
                        source: image
                        sourceSize.width: 294
                        sourceSize.height: 150

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                wraper.ListView.view.visible = false
                                wraper.ListView.view.itemTitle = name
                                wraper.ListView.view.itemImage = image
                                wraper.ListView.view.itemDetail = detail
                                wraper.ListView.view.itemPrice = price
                                wraper.ListView.view.itemVisible = true
                                wraper.ListView.view.itemViewState = "after"
                            }
                        }
                    }

                    Rectangle {
                        id: nameRect
                        width: parent.width; height: 32
                        anchors.left: parent.left
                        anchors.top: parent.bottom
                        color: Global.hotColor

                        Text {
                            id: nameText
                            text: name
                            anchors.left: parent.left; anchors.leftMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 14
                            color: "white"
                        }

                        Text {
                            id: priceText
                            text: "￥ " + price + " 元"
                            anchors.right: parent.right; anchors.rightMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 14
                            color: "white"
                        }
                    }
                }
            }
        }
    }
}
