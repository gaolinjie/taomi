import QtQuick 1.0

GridView {
    id: unsentView
    model: UnsentModel{}
    delegate: UnsentDelegate{}
    cacheBuffer: 100
    cellWidth: 465
    cellHeight: 80
    width: 1000
    height: 180
    flow: GridView.TopToBottom
}
