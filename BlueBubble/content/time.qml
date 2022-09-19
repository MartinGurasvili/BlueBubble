import QtQuick 2.15

Item {
    width: 500
    height: 110
    x: 20

    property string msg:"time"

    Rectangle {
        id: rectangle
         //property alias text: text1.text
        
        // y: 42

        width: 140
        height: 27
        color: "#33000000"
        radius: 20
        anchors.verticalCenterOffset: 1
        anchors.horizontalCenterOffset: 0

        // anchors.rightMargin: 148
        anchors.centerIn: parent

        Text {
            id: text1
            color: "#ffffff"
            text: msg
            width: parent.width
            height: parent.height
            font.pixelSize: 15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            //            horizontalAlignment: Text.AlignLeft
//            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
            minimumPixelSize: 16
            minimumPointSize: 16

            anchors.centerIn: parent
        }


    }



}
