import QtQuick 1.0

Item {
    id: itemRect
    width: parent.width
    height: parent.height

    property string image: ""
    property string name: ""

    Image {
        id: itemImage
        source: itemRect.image
        sourceSize.width: 235
        sourceSize.height: 120
        state: 'inlist'

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (itemImage.state == 'inlist') {
                    itemImage.state = 'popup'
                }
                else {
                    itemImage.state = 'inlist'
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
                PropertyChanges { target: itemImage; x: 60; y: 0;
                                  sourceSize.width: 560; sourceSize.height: 310}
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
            text: itemRect.name
            x: 10
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 14
            color: "white"
        }
    }
}
