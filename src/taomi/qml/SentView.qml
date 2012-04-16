import QtQuick 1.0

GridView {
    id: sentView
    //anchors.left: unsentView.left
    //anchors.top: sendedButton.bottom; anchors.topMargin: 15
    model: SentModel{}
    delegate: SentDelegate{}
    cacheBuffer: 100
    cellWidth: 465
    cellHeight: 80
    width: 1000
    height: 180
    flow: GridView.TopToBottom
}
