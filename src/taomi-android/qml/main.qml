import QtQuick 1.0

Item {
    id: screen
    width: 1280; height: 800

    Component.onCompleted: {
        var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
    }

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
