// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../js/global.js" as Global

Item {
    id: addPanel
    width: 400
    height: 800
    z: 2
    state: "newtype"

    Connections{
        target: seatCategory
        onClearEdit: {
            clearEdit();
        }
        onRefreshEdit: {
            refreshEdit();
        }
    }

    states: [
        State {
            name: "newtype"
            PropertyChanges { target: title; text: "新 建" }
            //PropertyChanges { target: selectNewTypeComboBox; prompt: "类别" }
            PropertyChanges { target: typeNameTitle; visible: true }
            PropertyChanges { target: seatNameTitle; visible: false }
        },
        State {
            name: "edittype"
            PropertyChanges { target: title; text: "编 辑" }
            //PropertyChanges { target: selectNewTypeComboBox; prompt: "类别" }
            PropertyChanges { target: typeNameTitle; visible: true }
            PropertyChanges { target: seatNameTitle; visible: false }
        },
        State {
            name: "newseat"
            PropertyChanges { target: title; text: "新 建" }
            //PropertyChanges { target: selectNewTypeComboBox; prompt: "座位" }
            PropertyChanges { target: typeNameTitle; visible: false }
            PropertyChanges { target: seatNameTitle; visible: true }
        },
        State {
            name: "editseat"
            PropertyChanges { target: title; text: "编 辑" }
            //PropertyChanges { target: selectNewTypeComboBox; prompt: "座位" }
            PropertyChanges { target: typeNameTitle; visible: false }
            PropertyChanges { target: seatNameTitle; visible: true }
        }
    ]

    Rectangle {
        id: panel
        width: parent.width
        height: parent.height
        color: "#de9317"
        z: 2

        Image {
            id: nextButton
            anchors.left: title.right; anchors.leftMargin: 205
            anchors.bottom: title.bottom; anchors.bottomMargin: 5
            sourceSize.width: 36; sourceSize.height: 36
            source: "qrc:/images/next.png"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    addPanel.x = 1280
                }
            }
        }

        Text {
            id: title
            x: 40; y: 40
            text: "新 建"
            font.pixelSize: 38
            font.family: "微软雅黑"
            smooth: true
            color: "white"
        }

        Item {
            id: editRect
            width: 400
            height:700
            anchors.top: title.bottom; anchors.topMargin: 40
            anchors.left: title.left

            property string backColor: ""
            property string name: ""
            property string image: ""

            Behavior on x {
                NumberAnimation { duration: 600; easing.type: Easing.OutQuint}
            }


            Text {
                id: newTypeTitle
                text: "新建项目:"
                anchors.left: editRect.left
                anchors.top: editRect.top// anchors.topMargin: 1540
                font.pixelSize: 16
                font.family: "微软雅黑"
                smooth: true
                color: "white"
            }

            ComboBox {
                id: selectNewTypeComboBox
                prompt: "类别"
                anchors.left: newTypeTitle.left
                anchors.top: newTypeTitle.bottom; anchors.topMargin: 15
                dropDown: true
                visible: newTypeTitle.visible
                z: 2
                contentModel: newTypeModel
                onOperate: {
                    if (index == 0) {
                        addPanel.state = "newtype"
                    }
                    else {
                        addPanel.state = "newseat"
                    }
                }
                ListModel {
                    id: newTypeModel
                    ListElement {
                        name: "类别"
                    }
                    ListElement {
                        name: "座位"
                    }
                }
            }

            Text {
                id: typeNameTitle
                text: "类别名称:"
                anchors.left: selectNewTypeComboBox.left
                anchors.top: selectNewTypeComboBox.bottom; anchors.topMargin: 30
                font.pixelSize: 16
                font.family: "微软雅黑"
                smooth: true
                color: "white"
            }

            Rectangle {
                id: typeNameEdit
                width: 320; height: 36
                color: "#de9317"
                border.color: "white"//"#d54d34"
                border.width: 2
                anchors.left: typeNameTitle.left
                anchors.top: typeNameTitle.bottom; anchors.topMargin: 15
                visible: typeNameTitle.visible

                TextEdit {
                    id: typeNameTextEdit
                    width: 300
                    text: ""
                    font.pixelSize: 20
                    font.family: "微软雅黑"
                    smooth: true
                    color: "white"
                    focus: true
                    anchors.centerIn: parent
                    clip: true
                }
            }

            Text {
                id: seatNameTitle
                text: "座位名称:"
                anchors.left: selectNewTypeComboBox.left
                anchors.top: selectNewTypeComboBox.bottom; anchors.topMargin: 30
                font.pixelSize: 16
                font.family: "微软雅黑"
                smooth: true
                color: "white"
            }

            Rectangle {
                id: seatNameEdit
                width: 320; height: 36
                color: "#de9317"
                border.color: "white"//"#d54d34"
                border.width: 2
                anchors.left: typeNameTitle.left
                anchors.top: typeNameTitle.bottom; anchors.topMargin: 15
                visible: seatNameTitle.visible

                TextEdit {
                    id: seatNameTextEdit
                    width: 300
                    text: ""
                    font.pixelSize: 20
                    font.family: "微软雅黑"
                    smooth: true
                    color: "white"
                    focus: true
                    anchors.centerIn: parent
                    clip: true
                }
            }

            Text {
                id: seatCapacityTitle
                text: "座位容量:"
                anchors.left: seatNameEdit.left
                anchors.top: seatNameEdit.bottom; anchors.topMargin: 30
                font.pixelSize: 16
                font.family: "微软雅黑"
                smooth: true
                color: "white"
                visible: seatNameTitle.visible
            }

            Rectangle {
                id: seatCapacityEdit
                width: 320; height: 36
                color: "#de9317"
                border.color: "white"//"#d54d34"
                border.width: 2
                anchors.left: seatCapacityTitle.left
                anchors.top: seatCapacityTitle.bottom; anchors.topMargin: 15
                visible: seatNameTitle.visible

                TextEdit {
                    id: seatCapacityTextEdit
                    width: 300
                    text: ""
                    font.pixelSize: 20
                    font.family: "微软雅黑"
                    smooth: true
                    color: "white"
                    focus: true
                    anchors.centerIn: parent
                    clip: true
                }
            }

            Rectangle {
                id: okButton
                anchors.left: selectNewTypeComboBox.left
                anchors.bottom: parent.bottom; anchors.bottomMargin: 70
                width: 140; height: 27
                color: "#de9317"
                border.color: "white"
                border.width: 2

                Text {
                    text: "确 定"
                    anchors.centerIn: parent
                    color: "white"
                    font.family: "微软雅黑"
                    smooth: true
                    font.pixelSize: 16
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        okButton.color = "#d54d34"
                    }
                    onClicked: {
                        if (addPanel.state == "newtype" && typeNameTextEdit.text == "") {
                        }
                        else {
                            if (addPanel.state == "newtype") {
                                var index = seatCategory.model.count;
                                for (var i = 0; i < seatCategory.model.count; i++) {
                                    seatCategory.model.setProperty(i, "active", 0);
                                }
                                var newscid = idManager.createID();;
                                seatCategory.model.insert(index, {"scid": newscid, "name": typeNameTextEdit.text, "active": 1});
                                //Global.seatType = newscid;
                                seatCategory.changeSeatType();
                            }
                            else if (addPanel.state == "edittype") {
                                var index = 0;
                                while (index < seatCategory.model.count) {
                                    if (seatCategory.model.get(index).active == 1) {
                                        seatCategory.model.get(index).name = typeNameTextEdit.text;
                                        break;
                                    }
                                    index++;
                                }
                            }
                            else if (addPanel.state == "newseat") {
                                var st = ""
                                for (var i = 0; i < seatCategory.model.count; i++) {                                  
                                    if (seatCategory.model.get(i).active == 1) {
                                        st = seatCategory.model.get(i).name;
                                    }
                                }
                                var index = seatView.contentModel.count;
                                var newsid = idManager.createID();;
                                seatView.contentModel.insert(index, {"sid": newsid, "scid": Global.seatType, "seat": seatNameTextEdit.text, "type": st, "capacity": seatCapacityTextEdit.text, "active": 1});
                            }
                            else if (addPanel.state == "editseat") {
                                var index = 0;
                                while (index < seatCategory.model.count) {
                                    if (seatView.contentModel.get(index).active == 1) {
                                        seatView.contentModel.get(index).seat = seatNameTextEdit.text;
                                        seatView.contentModel.get(index).capacity = seatCapacityTextEdit.text;
                                        break;
                                    }
                                    index++;
                                }
                            }

                            addPanel.x = 1280;
                            clearEdit();
                            syncManager.setSyncOn(); // 待定
                        }
                    }
                    onReleased: {
                        okButton.color = "#de9317"
                    }
                }
            }

            Rectangle {
                id: cancelButton
                anchors.right: selectNewTypeComboBox.right
                anchors.bottom: okButton.bottom
                width: 140; height: 27
                color: "#de9317"
                border.color: "white"
                border.width: 2

                Text {
                    text: "取 消"
                    anchors.centerIn: parent
                    color: "white"
                    font.pixelSize: 16
                    font.family: "微软雅黑"
                    smooth: true
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: {
                        cancelButton.color = "#d54d34"
                    }
                    onClicked: {
                        clearEdit();
                        addPanel.x = 1280;
                    }
                    onReleased: {
                        cancelButton.color = "#de9317"
                    }
                }
            }
        }
    }

    function clearEdit() {
        typeNameTextEdit.text = "";
        seatNameTextEdit.text = "";
        seatCapacityTextEdit.text = "";
        //addPanel.state = "newtype";
    }

    function refreshEdit() {
        if (addPanel.state == "edittype") {
            for (var i = 0; i < seatCategory.model.count; i++) {
                if (seatCategory.model.get(i).active == 1) {
                    typeNameTextEdit.text = seatCategory.model.get(i).name;
                }
            }
        }
        else if (addPanel.state == "editseat") {
            for (var i = 0; i < seatView.contentModel.count; i++) {
                if (seatView.contentModel.get(i).active == 1) {
                    seatNameTextEdit.text = seatView.contentModel.get(i).seat;
                    seatCapacityTextEdit.text = seatView.contentModel.get(i).capacity;
                }
            }
        }
    }

    BorderImage {
        anchors.fill: panel
        anchors { leftMargin: -9; topMargin: -6; rightMargin: -8; bottomMargin: -8 }
        border { left: 10; top: 10; right: 10; bottom: 10 }
        source: "qrc:/images/shadow.png";
        smooth: true
        z: 1
    }
}
