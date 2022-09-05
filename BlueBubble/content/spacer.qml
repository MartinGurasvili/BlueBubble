import QtQuick 2.15

Item {
    id: item3
    x: 0
    y: 0
    width: 495
    height: 100
    property string msg:amazon
    property color c1:"#2af598"
    property color c2:"#009efd"
    Text {
        id: text3
        x: 101
        y: 27
        width: 187
        height: 47
        color: "#000000"
        text: qsTr("amazon")
        font.pixelSize: 30
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.styleName: "Light"
        font.family: ff
        opacity: 0
    }
}
