import QtQuick 2.15

Item {
    id: item3
    x: 0
    y: 0
    width: 495
    height: 100
    property string msg:""
    property color c1:"#2af598"
    property color c2:"#009efd"
    MouseArea
    {
        width: parent.width
        height: parent.height
//        onPressAndHold:console.log("darg")

        onClicked: {
            mainani.running = true
            viskill.running = true
            addUser.visible = true
            aufadein.running = true

        }
    }
    Rectangle {
        id: rectangle3
        x: -8
        y: 0
        width: 516
        height: 100
        opacity: 0.106
        color: "#00000000"
        border.color: "#4d000000"
        border.width: 1

    }

    Rectangle {
        id: rectangle4
        x: 21
        y: 20
        width: 60
        height: 60
        color: "#00ffffff"
        radius: 30
        border.color: "#ababab"
        border.width: 2
    }

    Text {
        id:text3
        x: 101
        y: 27
        width: 187
        height: 47
        color: "#a9a9a9"
        text: "Add Users"
        font.pixelSize: 30
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.styleName: "Light"
        font.family: ff
    }

    Text {
        id: text4
        x: 21
        y: 20
        width: 60
        height: 54
        color: "#a9a9a9"
        text: "+"
        font.pixelSize: 40
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.styleName: "Light"
        font.family: ff
    }

}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.66}D{i:5}
}
##^##*/
