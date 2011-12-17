import QtQuick 1.0

Item {
    id: screen
    width: 1024; height: 600

    Loader {
        id: mainLoader
        source: "qrc:/qml/start.qml"
    }

    Connections{
        target: mainLoader.item
        onLoadStart: {mainLoader.source = "qrc:/qml/start.qml"}
        onLoadRect: {mainLoader.source = qmlFile}
    }
}
