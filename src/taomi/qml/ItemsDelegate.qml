import QtQuick 1.0

Component {
    id: itemsDelegate

    Item {
        id: wraper
        width: 235; height: 120 * 2 + 38
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
                        state: 'inlist'

                        Text {
                            id: titleText
                            text: title
                            x: 620; y: 0
                            font.pixelSize: 22
                            color: "white"
                            visible: false
                            Behavior on x {
                                NumberAnimation { duration: 600; easing.type: Easing.OutQuint}
                            }
                        }

                        Text {
                            id: detailsText
                            text: "                            Made a similar layout like last \n
                            time, with a couple of different\n
                            panels. Also added some extras \n
                            like the clock and the sidebar, \n
                            wondering if I should include it\n
                            in Omnimo in the next update."
                            x: 630; y: 46
                            font.pixelSize: 14
                            color: "white"
                            visible: false
                            Behavior on x {
                                NumberAnimation { duration: 600; easing.type: Easing.OutQuint}
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (itemImage.state == 'inlist') {
                                    itemImage.state = 'popup'
                                    wraper.ListView.view.visible = false
                                    titleText.visible = true
                                    detailsText.visible = true
                                }
                                else {
                                    itemImage.state = 'inlist'
                                    wraper.ListView.view.visible = true
                                    titleText.visible = false
                                    detailsText.visible = false
                                }
                            }
                        }

                        states: [
                            State {
                                name: 'inlist'
                                ParentChange { target: itemImage; parent: itemRect}
                                PropertyChanges { target: itemImage;
                                                  sourceSize.width: 235; sourceSize.height: 120}
                            },
                            State {
                                name: 'popup'
                                ParentChange { target: itemImage; parent: itemRect.parent.parent.parent.parent.parent}
                                PropertyChanges { target: itemImage; x: 130; y: 120;
                                                  sourceSize.width: 560; sourceSize.height: 310}
                                PropertyChanges { target: titleText; x: 600}
                                PropertyChanges { target: detailsText; x: 520}
                            }
                        ]
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
