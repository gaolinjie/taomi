import QtQuick 1.0

Component {
    id: itemsDelegate

    Item {
        width: 235; height: 120 * 2 + 38
        Column {
            id: column
            anchors.centerIn: parent
            spacing: 38

            Repeater {
                model: columnModel

                Item {
                    id: wraper
                    width: 235; height: 120

                    Component.onCompleted: {
                        var component;
                        component = Qt.createComponent("ItemRect.qml");
                        component.createObject(wraper, {"image": image, "name": title});
                    }
                }
            }
        }
    }
}
