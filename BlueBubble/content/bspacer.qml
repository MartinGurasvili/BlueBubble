import QtQuick 2.15

Item {
    width: 60
    height: 110
    opacity: 0
    property string msg: ""
    property bool hig: tm.width< 230
    Rectangle {
        id: rectangle
         //property alias text: text1.text
        x: 0
        y: 0

        width: (tm.width<200) ? tm.width*1.2 : 240
        height: (tm.width>230) ? tm.height*3 : tm.height*1.5
        color: "#4d003aff"
        radius: 20
        anchors.right:parent.right

        Text {
            id: text1
            color: "#ffffff"
            text: msg
            width: (tm.width<210) ? tm.width*1.2 : 240
            height: (tm.width>230) ? tm.height*3 : tm.height*2
            font.pixelSize: 21
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            //            horizontalAlignment: Text.AlignLeft
//            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
            minimumPixelSize: 16
            minimumPointSize: 16

            anchors.centerIn: parent
        }
        TextMetrics {
                id: tm
                font: text1.font
                text: text1.text
            }

    }



}
