import QtQuick 2.15

Item {
    width: 30
    height: rectangle.height+10
    property string msg: "helloshjkhasfkjhajksfhjkhsfjkajkshfjkasfhafs"
    // property bool hig: tm.width< 230
    property bool htog: false
    x:-460
    anchors.leftMargin: 0
    Rectangle {
        id: rectangle
        x: 0
        y: 0
        //property alias text: text1.text
        // anchors.leftMargin: 220
        // anchors.rightMargin: 400
        
        anchors.left: parent.right;
        //  anchors.rightMargin: -220

        width: (tm.width<100) ? tm.width*2 : 250
        height: (tm.text.length/40)*35+40
        color: "#bdc3c7"

        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop {
                position: 1
                color: "#2c3e50"
            }

            GradientStop {
                position: 0
                color: "#bdc3c7"
            }
        }
        radius: 20
        opacity: 0.8
        
        

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
        MouseArea {
            width:parent.width
            height:parent.height
            onDoubleClicked:{
                if(htog==false){
                    inn.running = true

                    htog=true
                }
                else{
                    outt.running = true
                    htog=false
                }
            }
        }

        Image {
            id: heart
            // x: -37
            y: -12
            anchors.left: parent.right
            anchors.leftMargin:-40
            width: 77
            height: 27
            opacity: 0
            source: "images/heart.svg.png"
            focus: true
            antialiasing: true
            visible:true
            fillMode: Image.PreserveAspectFit
            PropertyAnimation {
                id:  inn
                target:heart
                property: "opacity"
                paused: false
                to: 0.7
                duration: 700
                running: false
                from: 0
            }
            PropertyAnimation {
                id:  outt
                target:heart
                property: "opacity"
                to: 0
                duration: 700
                running: false
                from: 0.7

            }
        }

        TextMetrics {
            id: tm
            font: text1.font
            text: text1.text
        }



    }




}
