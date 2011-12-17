import QtQuick 1.0

Component {
    id: startDelegate

    Item {
        width: 235; height: 372
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
                        component = Qt.createComponent("IconRect.qml");
                        component.createObject(wraper, {"iconSource": iconSource, "iconTitle": iconTitle});
                    }

                    states: State {
                        name: "active"
                        PropertyChanges { target: wraper; width: 235; height: 120; opacity: 1 }
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
