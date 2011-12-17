import QtQuick 1.0

ListModel {
    id: startModel

    ListElement {
        columnCategory: "first"
        columnState: "normal"
        sizeDuration: 100
        opacityDuration: 100
        columnModel: [
            ListElement {
                rectColor: "#4eb3b9"
                slotQml: "rect1.qml"
                iconSource: "qrc:/images/favs.png"
                iconTitle: "喜欢"
            },
            ListElement {
                rectColor: "#5859b9"
                slotQml: "rect1.qml"
                iconSource: "qrc:/images/note.png"
                iconTitle: "订单"
            },
            ListElement {
                rectColor: "#6e155f"
                slotQml: "rect1.qml"
                iconSource: "qrc:/images/POI.png"
                iconTitle: "座位"
            }
        ]
    }

    ListElement {
        columnCategory: "first"
        columnState: "normal"
        sizeDuration: 200
        opacityDuration: 300
        columnModel: [
            ListElement {
                rectColor: "#d54d34"
                slotQml: "rect1.qml"
                iconSource: "qrc:/images/rss.png"
                iconTitle: "新闻"
            },
            ListElement {
                rectColor: "#96b232"
                slotQml: "rect1.qml"
                iconSource: "qrc:/images/search.png"
                iconTitle: "搜索"
            },
            ListElement {
                rectColor: "#034888"
                slotQml: "rect1.qml"
                iconSource: "qrc:/images/skaner.png"
                iconTitle: "优惠"
            }
        ]
    }

    ListElement {
        columnCategory: "first"
        columnState: "normal"
        sizeDuration: 300
        opacityDuration: 400
        columnModel: [
            ListElement {
                rectColor: "#de9317"
                slotQml: "rect1.qml"
                iconSource: "qrc:/images/sett-big.png"
                iconTitle: "设置"
            },
            ListElement {
                rectColor: "#1BA1E2"
                slotQml: "rect1.qml"
                iconSource: "qrc:/images/tasks.png"
                iconTitle: "记录"
            },
            ListElement {
                rectColor: "#4eb3b9"
                slotQml: "rect1.qml"
                iconSource: "qrc:/images/video.png"
                iconTitle: "视频"
            }
        ]
    }

    ListElement {
        columnCategory: "second"
        columnState: "normal"
        sizeDuration: 500
        opacityDuration: 600
        columnModel: [
            ListElement {
                rectColor: "#FF0097"
                slotQml: "rect1.qml"
                iconSource: ""
                iconTitle: ""
            },
            ListElement {
                rectColor: "#6e155f"
                slotQml: "rect1.qml"
                iconSource: ""
                iconTitle: ""
            },
            ListElement {
                rectColor: "#d54d34"
                slotQml: "rect1.qml"
                iconSource: ""
                iconTitle: ""
            }
        ]
    }

    ListElement {
        columnCategory: "second"
        columnState: "normal"
        sizeDuration: 500
        opacityDuration: 600
        columnModel: [
            ListElement {
                rectColor: "#96b232"
                slotQml: "rect1.qml"
                iconSource: ""
                iconTitle: ""
            },
            ListElement {
                rectColor: "#034888"
                slotQml: "rect1.qml"
                iconSource: ""
                iconTitle: ""
            },
            ListElement {
                rectColor: "#de9317"
                slotQml: "rect1.qml"
                iconSource: ""
                iconTitle: ""
            }
        ]
    }

    ListElement {
        columnCategory: "second"
        columnState: "normal"
        sizeDuration: 100
        opacityDuration: 100
        columnModel: [
            ListElement {
                rectColor: "#1BA1E2"
                slotQml: "rect1.qml"
                iconSource: ""
                iconTitle: ""
            },
            ListElement {
                rectColor: "#4eb3b9"
                slotQml: "rect1.qml"
                iconSource: ""
                iconTitle: ""
            },
            ListElement {
                rectColor: "#1BA1E2"
                slotQml: "rect1.qml"
                iconSource: ""
                iconTitle: ""
            }
        ]
    }

    ListElement {
        columnCategory: "third"
        columnState: "normal"
        sizeDuration: 100
        opacityDuration: 100
        columnModel: [
            ListElement {
                rectColor: "#6e155f"
                slotQml: "rect1.qml"
                iconSource: ""
                iconTitle: ""
            },
            ListElement {
                rectColor: "#de9317"
                slotQml: "rect1.qml"
                iconSource: ""
                iconTitle: ""
            },
            ListElement {
                rectColor: "#6e155f"
                slotQml: "rect1.qml"
                iconSource: ""
                iconTitle: ""
            }
        ]
    }

    ListElement {
        columnCategory: "third"
        columnState: "normal"
        sizeDuration: 100
        opacityDuration: 100
        columnModel: [
            ListElement {
                rectColor: "#FF0097"
                slotQml: "rect1.qml"
                iconSource: ""
                iconTitle: ""
            },
            ListElement {
                rectColor: "#5859b9"
                slotQml: "rect1.qml"
                iconSource: ""
                iconTitle: ""
            },
            ListElement {
                rectColor: "#034888"
                slotQml: "rect1.qml"
                iconSource: ""
                iconTitle: ""
            }
        ]
    }
}
