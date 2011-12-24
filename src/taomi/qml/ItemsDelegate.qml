import QtQuick 1.0

Component {
    id: itemsDelegate

    Item {
        id: wraper
        width: 235; height: 120 * 2 + 38
        signal showItem(string name, string image)

        Column {
            id: column
            anchors.centerIn: parent
            spacing: 38

            Repeater {
                model: columnModel

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
                                wraper.ListView.view.itemTitle = title
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
                        color: "#d54d34"

                        Text {
                            id: nameText
                            text: title
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
