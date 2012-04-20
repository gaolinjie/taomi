import QtQuick 1.0
import "../js/global.js" as Global

GridView {
    id: seatView
    model: seatModel
    delegate: seatDelegate
    cacheBuffer: 100
    cellWidth: 420
    cellHeight: 45
    width: 1000
    height: 270
    flow: GridView.TopToBottom
    x: 100
    Component.onCompleted: {
        seatView.x = 0;
    }

    Behavior on x {
        NumberAnimation { duration: 400; easing.type: Easing.OutQuint}
    }

    Component {
        id: seatDelegate

        Rectangle {
             width: 410; height: 40
             border.width: 2
             border.color: "white"
             color: active == 1 ? Global.hotColor : Global.rectColor

             Text {
                 text: seat
                 anchors.centerIn: parent
                 color: "white"
                 font.pixelSize: 16
             }

             MouseArea {
                 anchors.fill: parent

                 onClicked: {
                     for (var i = 0; i < seatView.model.count; i++) {
                         if (seatView.model.get(i).sid == sid) {
                             seatView.model.setProperty(i, "active", 1);
                         }
                         else {
                             seatView.model.setProperty(i, "active", 0);
                         }
                     }
                 }
             }
        }
    }

    ListModel {
        id: seatModel
        Component.onCompleted: loadItemsData()
        Component.onDestruction: saveItemsData()
        function loadItemsData() {
            var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
            db.transaction(
                function(tx) {
                    tx.executeSql('CREATE TABLE IF NOT EXISTS seatModel(sid INTEGER key, cid INTEGER, seat TEXT, active INTEGER)');
                    var rs = tx.executeSql('SELECT * FROM seatModel WHERE cid = ?', [Global.seatType]);
                    var index = 0;
                    if (rs.rows.length > 0) {
                        while (index < rs.rows.length) {
                            var item = rs.rows.item(index);
                            seatModel.append({"sid": item.sid,
                                              "cid": item.cid,
                                              "seat": item.seat,
                                              "active": item.active});
                            index++;
                        }
                    }
                    else {
                        seatModel.append({"sid": 0,
                                          "cid": 0,
                                          "seat": "1 号",
                                          "active": 0});
                        seatModel.append({"sid": 1,
                                             "cid": 0,
                                          "seat": "2 号",
                                             "active": 0});
                        seatModel.append({"sid": 2,
                                             "cid": 0,
                                          "seat": "3 号",
                                             "active": 0});
                        seatModel.append({"sid": 3,
                                             "cid": 0,
                                          "seat": "4 号",
                                             "active": 0});
                        seatModel.append({"sid": 4,
                                             "cid": 0,
                                          "seat": "5 号",
                                             "active": 0});
                        seatModel.append({"sid": 5,
                                             "cid": 0,
                                          "seat": "6 号",
                                             "active": 0});
                        seatModel.append({"sid": 6,
                                             "cid": 0,
                                          "seat": "7 号",
                                             "active": 0});
                        seatModel.append({"sid": 7,
                                             "cid": 0,
                                          "seat": "8 号",
                                             "active": 0});
                        seatModel.append({"sid": 8,
                                             "cid": 0,
                                          "seat": "9 号",
                                             "active": 0});
                        seatModel.append({"sid": 9,
                                             "cid": 0,
                                          "seat": "10 号",
                                             "active": 0});
                        seatModel.append({"sid": 10,
                                             "cid": 0,
                                          "seat": "11 号",
                                             "active": 0});
                        seatModel.append({"sid": 11,
                                             "cid": 0,
                                          "seat": "12 号",
                                             "active": 0});
                        seatModel.append({"sid": 12,
                                             "cid": 1,
                                          "seat": "吉祥厅",
                                             "active": 0});
                        seatModel.append({"sid": 13,
                                             "cid": 1,
                                          "seat": "如意厅",
                                             "active": 0});
                        seatModel.append({"sid": 14,
                                             "cid": 1,
                                          "seat": "功成厅",
                                             "active": 0});
                        seatModel.append({"sid": 15,
                                             "cid": 1,
                                          "seat": "名就厅",
                                             "active": 0});
                        seatModel.append({"sid": 16,
                                             "cid": 1,
                                          "seat": "花好厅",
                                             "active": 0});
                        seatModel.append({"sid": 17,
                                             "cid": 1,
                                          "seat": "月圆厅",
                                             "active": 0});
                        seatModel.append({"sid": 18,
                                             "cid": 1,
                                          "seat": "福禄厅",
                                             "active": 0});
                        seatModel.append({"sid": 19,
                                             "cid": 1,
                                          "seat": "亨通厅",
                                             "active": 0});
                        seatModel.append({"sid": 20,
                                             "cid": 1,
                                          "seat": "荣华厅",
                                             "active": 0});
                        seatModel.append({"sid": 21,
                                             "cid": 1,
                                          "seat": "富贵厅",
                                             "active": 0});
                        seatModel.append({"sid": 22,
                                             "cid": 1,
                                          "seat": "财寿厅",
                                             "active": 0});
                        seatModel.append({"sid": 23,
                                             "cid": 1,
                                          "seat": "康宁厅",
                                             "active": 0});
                        seatModel.append({"sid": 24,
                                             "cid": 2,
                                          "seat": "VIP 1",
                                             "active": 0});
                        seatModel.append({"sid": 25,
                                             "cid": 2,
                                          "seat": "VIP 2",
                                             "active": 0});
                        seatModel.append({"sid": 26,
                                             "cid": 2,
                                          "seat": "VIP 3",
                                             "active": 0});
                        seatModel.append({"sid": 27,
                                             "cid": 2,
                                          "seat": "VIP 4",
                                             "active": 0});
                        seatModel.append({"sid": 28,
                                             "cid": 2,
                                          "seat": "VIP 5",
                                             "active": 0});
                        seatModel.append({"sid": 29,
                                             "cid": 2,
                                          "seat": "VIP 6",
                                             "active": 0});
                        seatModel.append({"sid": 30,
                                             "cid": 3,
                                          "seat": "订 1",
                                             "active": 0});
                        seatModel.append({"sid": 31,
                                             "cid": 3,
                                          "seat": "订 2",
                                             "active": 0});
                        seatModel.append({"sid": 32,
                                             "cid": 3,
                                          "seat": "订 3",
                                             "active": 0});
                        seatModel.append({"sid": 33,
                                             "cid": 3,
                                          "seat": "订 4",
                                             "active": 0});
                        seatModel.append({"sid": 34,
                                             "cid": 3,
                                          "seat": "订 5",
                                             "active": 0});
                        seatModel.append({"sid": 35,
                                             "cid": 3,
                                          "seat": "订 6",
                                             "active": 0});
                    }
                }
            )
        }

        function saveItemsData() {
            var db = openDatabaseSync("DemoDB", "1.0", "Demo Model SQL", 50000);
            db.transaction(
                function(tx) {
                    //tx.executeSql('DROP TABLE seatModel');
                    tx.executeSql('CREATE TABLE IF NOT EXISTS seatModel(sid INTEGER key, cid INTEGER, seat TEXT, active INTEGER)');

                    var index = 0;
                    var item;
                    while (index < seatModel.count) {
                        item = seatModel.get(index);
                        if (item.active == 1) {
                            tx.executeSql('UPDATE seatModel SET active = 0');
                            tx.executeSql('UPDATE seatModel SET active = ? WHERE sid = ?', [1, item.sid]);
                        }
                        index++;
                    }
                }
            )
        }
    }
}
