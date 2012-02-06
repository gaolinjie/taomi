import QtQuick 1.0

Component {
    id: startDelegate

    Item {
        width: 300; height: 465
        Column {
            id: column
            anchors.centerIn: parent
            spacing: 6

            Repeater {
                model: columnModel

                Item {
                    id: wraper
                    width: 47; height: 24
                    state: columnState
                    opacity: 0

                    Component.onCompleted: {
                        var component;
                        if (style == "IMAGE_RECT") {
                            component = Qt.createComponent("ImageRect.qml");
                            component.createObject(wraper, {"iconSource": image, "iconTitle": title});

                        }
                        else {
                            component = Qt.createComponent("IconRect.qml");
                            component.createObject(wraper, {"iconSource": image, "iconTitle": title});
                        }
                    }

                    states: State {
                        name: "active"
                        PropertyChanges { target: wraper; width: 300; height: 150; opacity: 1 }
                    }

                    transitions: [
                        Transition {
                            from: 'normal'; to: 'active'

                            NumberAnimation {
                                target: wraper
                                properties: 'width, height'
                                duration: sizeDuration
                                easing.type: Easing.Linear
                            }

                            NumberAnimation {
                                target: wraper
                                properties: 'opacity'
                                duration: opacityDuration
                                easing.type: Easing.Linear
                            }
                        }
                    ]
                }
            }
        }
    }
}
