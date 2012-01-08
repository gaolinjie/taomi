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
                rectColor: "#de9317"
                hotColor: "#d54d34"
                slotQml: "ItemsView.qml"
                image: "qrc:/images/Tagine.jpg"
                title: "特 色"
                style: "IMAGE_RECT"
                tag: "特色"
            },
            ListElement {
                rectColor: "#5859b9"
                hotColor: "#d54d34"
                slotQml: "rect.qml"
                image: "qrc:/images/note.png"
                title: "订单"
                style: "ICON_RECT"
            },
            ListElement {
                rectColor: "#1BA1E2"
                hotColor: "#4eb3b9"
                slotQml: "ItemsView.qml"
                image: "qrc:/images/Soft_Scamble_Breakfast.jpg"
                title: "套 餐"
                style: "IMAGE_RECT"
                tag: "套餐"
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
                rectColor: "#034888"
                hotColor: "#d54d34"
                slotQml: "rect.qml"
                image: "qrc:/images/skaner.png"
                title: "优惠"
                style: "ICON_RECT"
            },
            ListElement {
                rectColor: "#6e155f"
                hotColor: "#d54d34"
                slotQml: "rect.qml"
                image: "qrc:/images/POI.png"
                title: "座位"
                style: "ICON_RECT"
            },
            ListElement {
                rectColor: "#96b232"
                hotColor: "#6e155f"
                slotQml: "ItemsView.qml"
                image: "qrc:/images/Tomato-Basil-Lasagne.jpg"
                title: "主 食"
                style: "IMAGE_RECT"
                tag: "主食"
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
                rectColor: "#d54d34"
                hotColor: "#de9317"
                slotQml: "ItemsView.qml"
                image: "qrc:/images/Carrot-Ginger-Soup.jpg"
                title: "浓 汤"
                style: "IMAGE_RECT"
                tag: "浓汤"
            },
            ListElement {
                rectColor: "#4eb3b9"
                hotColor: "#96b232"
                slotQml: "ItemsView.qml"
                image: "qrc:/images/CheeseStraws.jpg"
                title: "小 食"
                style: "IMAGE_RECT"
                tag: "小食"
            },
            ListElement {
                rectColor: "#de9317"
                hotColor: "#d54d34"
                slotQml: "rect.qml"
                image: "qrc:/images/sett-big.png"
                title: "设置"
                style: "ICON_RECT"
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
                hotColor: "#d54d34"
                slotQml: "rect.qml"
                image: "qrc:/images/Kermit-Lynch-Wine.jpg"
                title: "红 酒"
                style: "IMAGE_RECT"
                tag: "红酒"
            },
            ListElement {
                rectColor: "#6e155f"
                hotColor: "#d54d34"
                slotQml: "rect.qml"
                image: "qrc:/images/Blueberry_muffins.jpg"
                title: "甜 品"
                style: "IMAGE_RECT"
                tag: "甜品"
            },
            ListElement {
                rectColor: "#d54d34"
                hotColor: "#d54d34"
                slotQml: "rect.qml"
                image: "qrc:/images/BimBimBop.jpg"
                title: "拼 盘"
                style: "IMAGE_RECT"
                tag: "拼盘"
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
                hotColor: "#d54d34"
                slotQml: "rect.qml"
                image: "qrc:/images/tasks.png"
                title: "记录"
                style: "ICON_RECT"
            },
            ListElement {
                rectColor: "#034888"
                hotColor: "#d54d34"
                slotQml: "rect.qml"
                image: "qrc:/images/baba-ganoush.jpg"
                title: "炒 饭"
                style: "IMAGE_RECT"
                tag: "炒饭"
            },
            ListElement {
                rectColor: "#de9317"
                hotColor: "#d54d34"
                slotQml: "rect.qml"
                image: "qrc:/images/rss.png"
                title: "新闻"
                style: "ICON_RECT"
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
                hotColor: "#d54d34"
                slotQml: "rect.qml"
                image: "qrc:/images/Tagine_Recipe.jpg"
                title: "食 谱"
                style: "IMAGE_RECT"
                tag: "食谱"
            },
            ListElement {
                rectColor: "#4eb3b9"
                hotColor: "#d54d34"
                slotQml: "rect.qml"
                image: "qrc:/images/video.png"
                title: "视频"
                style: "ICON_RECT"
            },
            ListElement {
                rectColor: "#5859b9"
                hotColor: "#d54d34"
                slotQml: "rect.qml"
                image: "qrc:/images/search.png"
                title: "搜索"
                style: "ICON_RECT"
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
                rectColor: "#d54d34"
                hotColor: "#d54d34"
                slotQml: "rect.qml"
                image: "qrc:/images/rustic_soup.jpg"
                title: "风 味"
                style: "IMAGE_RECT"
                tag: "风味"
            },
            ListElement {
                rectColor: "#de9317"
                hotColor: "#d54d34"
                slotQml: "rect.qml"
                image: "qrc:/images/Salmon_with_pesto.jpg"
                title: "时 蔬"
                style: "IMAGE_RECT"
                tag: "时蔬"
            },
            ListElement {
                rectColor: "#6e155f"
                hotColor: "#d54d34"
                slotQml: "rect.qml"
                image: "qrc:/images/BimBimBop.jpg"
                title: "煲 仔"
                style: "IMAGE_RECT"
                tag: "煲仔"
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
                rectColor: "#5859b9"
                hotColor: "#d54d34"
                slotQml: "rect.qml"
                image: "qrc:/images/Summer_Salad.jpg"
                title: "沙 拉"
                style: "IMAGE_RECT"
                tag: "沙拉"
            },
            ListElement {
                rectColor: "#034888"
                hotColor: "#d54d34"
                slotQml: "rect.qml"
                image: "qrc:/images/Cherries.jpg"
                title: "水 果"
                style: "IMAGE_RECT"
                tag: "水果"
            },
            ListElement {
                rectColor: "#FF0097"
                hotColor: "#d54d34"
                slotQml: "rect.qml"
                image: "qrc:/images/favs.png"
                title: "喜欢"
                style: "ICON_RECT"
            }
        ]
    }
}
