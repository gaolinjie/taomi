import QtQuick 1.0

Item {
    id: scrollBar

    property real position
    property real pageSize
    property string barColor: "black"

    Rectangle {
        id: background
        anchors.fill: parent
        opacity: 0.3
        color: "white"
        radius: (width / 2)
    }

    Rectangle {
        opacity: 0.7
        color: barColor
        radius: (width / 2)
        x: 1
        y: Math.min(Math.max(0.0, scrollBar.position),
                    Math.max(0.0, 1.0 - scrollBar.pageSize)) * (scrollBar.height - 2) + 1
        width: parent.width - 2
        height: Math.min(1.0, scrollBar.pageSize) * (scrollBar.height - 2)
    }
}
