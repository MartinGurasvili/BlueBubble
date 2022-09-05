import QtQuick 2.15

Item {
    width: 480
    height: 110

    property string msg:  new Date().toLocaleString(Qt.locale()).substring(0,(Date().toLocaleString(Qt.locale()).length-20))

    Rectangle {
        id: rectangle
         //property alias text: text1.text
        x: 190
        y: 42

        width: 140
        height: 27
        color: "#33000000"
        radius: 20

        anchors.rightMargin: 148

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
