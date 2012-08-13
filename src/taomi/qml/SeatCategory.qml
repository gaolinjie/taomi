import QtQuick 1.0
import "../js/global.js" as Global

ListView {
    id: seatCategory
    width: 1000; height: 44
    spacing: 10
    model: seatCategoryModel
    delegate: seatCategoryDelegate
    orientation: ListView.Horizontal
    cacheBuffer: 1000
    signal changeSeatType()
    signal clearEdit()
    signal refreshEdit()
    interactive: false

    Component {
        id: seatCategoryDelegate
        Item {
            id: seatCategoryWrapper
            width: 200; height: 40

            Rectangle {
                 id: seatCategoryRect
                 width: 200; height: 40
                 color: active == 0 ? "#de9317" : "#5859b9"

                 Text {
                     text: name
                     //anchors.centerIn: parent
                     anchors.left: parent.left
                     anchors.leftMargin: 20
                     anchors.verticalCenter: parent.verticalCenter
                     color: "white"//active == 1 ? "white" : "black"
                     font.pixelSize: 18
                     font.family: "微软雅黑"
                     font.letterSpacing: 3
                     smooth: true
                 }

                 Image {
                     id: checkIcon
                     source: "qrc:/images/check.png"
                     visible: active == 1 ? true : false
                     anchors.right: parent.right
                     anchors.rightMargin: 5
                     anchors.verticalCenter: parent.verticalCenter
                     sourceSize.width: 32
                     sourceSize.height: 32
                 }

                 MouseArea {
                     anchors.fill: parent
                     onClicked: {
                         for (var i = 0; i < seatCategory.model.count; i++) {
                             if (seatCategory.model.get(i).scid == scid) {
                                 seatCategory.model.setProperty(i, "active", 1);
                             }
                             else {
                                 seatCategory.model.setProperty(i, "active", 0);
                             }
                         }
                         //Global.seatType = scid;
                         //console.log(Global.seatType)
                         seatCategory.changeSeatType();
                     }
                 }
            }
        }
    }

    ListModel {
        id: seatCategoryModel
        Component.onCompleted: loadItemsData()
        Component.onDestruction: saveItemsData()
        function loadItemsData() {
            var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
            db.transaction(
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS seatTypeDB(scid TEXT key, name TEXT, active INTEGER)');
                    var rs = tx.executeSql('SELECT * FROM seatTypeDB');
                    var index = 0;
                    if (rs.rows.length > 0) {
                        while (index < rs.rows.length) {
                            var item = rs.rows.item(index);
                            if (item.active == 1) {
                                Global.seatType = item.scid;
                            }
                            seatCategoryModel.append({"scid": item.scid,
                                                      "name": item.name,
                                                      "active": item.active});
                            index++;
                        }                        
                    }
                }
            )
        }

        function saveItemsData() {
            var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
            db.transaction(
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS seatTypeDB(scid TEXT key, name TEXT, active INTEGER)');
                    tx.executeSql('CREATE TABLE IF NOT EXISTS seatItemDB(sid TEXT key, scid TEXT, seat TEXT, type TEXT, capacity INTEGER, active INTEGER)');
                    var rs = tx.executeSql('SELECT * FROM seatItemDB WHERE active = ?', [1]);
                    if (rs.rows.length > 0) {
                        var item = rs.rows.item(0);
                        tx.executeSql('UPDATE seatTypeDB SET active = 0 WHERE active = ?', [1]);
                        tx.executeSql('UPDATE seatTypeDB SET active = 1 WHERE scid = ?', [item.scid]);
                    }
                }
            )
        }
    }
}
