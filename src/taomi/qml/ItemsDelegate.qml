import QtQuick 1.0
import "../js/global.js" as Global

Component {
    id: itemsDelegate

    Item {
        id: wraper
        width: 235; height: 120 * 2 + 38
        signal showItem(string name, string image)

        Column {
            id: col
            anchors.centerIn: parent
            spacing: 38

            Repeater {
                model: column

                Item {
                    id: itemRect
                    width: 235
                    height: 120

                    Image {
                        id: itemImage
                        source: image
                        sourceSize.width: 235
                        sourceSize.height: 120

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                wraper.ListView.view.visible = false
                                wraper.ListView.view.itemTitle = name
                                wraper.ListView.view.itemImage = image
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
                            x: 10
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
