import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
//import backend


Window {
    id: mainWindow
    minimumWidth: 500
    minimumHeight: 800
    maximumWidth: 500
    maximumHeight: 700

    flags: Qt.Window | Qt.FramelessWindowHint |Qt.WindowStaysOnTopHint
    visible: true
    color: "#00000000"

    title: "BlueBubble"
    property int previousX
    property int previousY
    property string name: ""
    property string messaging: ""
    property color c11: "#000000"
    property color c22: "#000000"
    property string fv:"Rounded Sans Serifs"
    property string ff:'Helvetica Neue'
    property string fq:'Manrope Thin'
    //FontLoader { id: webFont; source: "https://fonts.google.com/specimen/Nunito" }
    property var sprite
    property var component;
    property var allmsgs : [ ]

    property var currentmsgs:ListModel{}
    property var allcon:ListModel{



        ListElement{
            element: "spacer.qml"
            name:"Blue Bubble"
            c1:"#ffafbd"
            c2:"#ffc3a0"
        }
        ListElement{
            element: " contact.qml"
            name:"coolguy"
            c1:"#ffafbd"
            c2:"#ffc3a0"
        }
        ListElement{
            element: " contact.qml"
            name:"jakub"
            c1:"#2193b0"
            c2:"#6dd5ed"
        }
        ListElement{
            element: " contact.qml"
            name:"amazon"
            c1:"#cc2b5e"
            c2:"#753a88"
        }
        ListElement{
            element: " contact.qml"
            name:"madguy123"
            c1:"#42275a"
            c2:"#734b6d"
        }
        ListElement{
            element: " contact.qml"
            name:"asasfasfa"
            c1:"#bdc3c7"
            c2:"#2c3e50"
        }
        ListElement{
            element: " contact.qml"
            name:"greenguy"
            c1:"#56ab2f"
            c2:"#a8e063"
        }
        ListElement{
            element: " contact.qml"
            name:"ice cream"
            c1:"#eecda3"
            c2:"#ef629f"
        }
        ListElement{
            element: " contact.qml"
            name:"graden"
            c1:"#ffd89b"
            c2:"#19547b"
        }



    }

    //    Bridge {
    //            id: bridge
    //        }
    Item {
        id: login
        visible:true

        PropertyAnimation {
            id: logout
            target:login
            property: "opacity"
            to: 0
            duration: 1000
            running: false
        }
        Rectangle {
            id:backk
            x: 0
            y: 0
            width: 500
            height: 800
            opacity: 1

            smooth: true
            visible: true
            color: "#cca6c0fe"
            //color: "#00000000"
            radius: 30
            border.width: -1
            Component.onCompleted: {
                name = bridge.load_user(name)
                console.log(name)
                if(name !="")
                {
                    login.visible = false;
                    mainn.visible = true;
                    mainanii.running= true
                }
            }
            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop {
                    position: 0
                    color: "#00c6ff"
                    ColorAnimation on color { to: "#3a7bd5"; duration: 15000 }
                }

                GradientStop {
                    position: 1
                    color: "#0072ff"
                    ColorAnimation on color { to: "#00c6ff"; duration: 15000 }

                }
            }




            Text {
                id: placeholder
                x: 56
                y: 413
                width: 383
                height: 41
                color: "#cecece"
                text: "Enter Username"
                font.pixelSize: 30
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.styleName: "Light"
                font.italic: true
                font.family: ff
                visible: true

            }
            TextInput {
                id: textInput
                x: 56
                y: 413
                width: 383
                height: 41
                color: "#ffffff"
                text: name
                font.pixelSize: 30
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.styleName: "Light"
                font.family: ff
                maximumLength : 15
                onTextChanged: {
                    name = text
                }
                Keys.onPressed: {
                    if (event.key == Qt.Key_Return) {
                        if(name !=""){
                            loaddd.color = "#ffffff"
                            logout.running= true
                            mainn.visible = true;
                            mainanii.running= true
                            bridge.login(name)
                        }}
                }
                MouseArea {
                    id :ma
                    anchors.fill: parent
                    propagateComposedEvents: true

                    onClicked: {
                        placeholder.visible= false;
                        ma.enabled = false;
                        textInput.selectByMouse =true;
                        textInput.focus = true;
                        textInput.selectByMouse = false;
                    }
                }

            }

            Rectangle
            {
                x: 45
                y: 395
                implicitWidth: 411
                implicitHeight: 77
                radius: 30
                color: "#000000"
                opacity:0.1


            }
            Text {
                id: title
                width: 342
                height: 82
                opacity: 0
                color: "#ffffff"
                text:"Welcome To Blue Bubble"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.styleName: "Thin"
                font.weight: Font.ExtraLight
                font.bold: true
                font.pointSize: 40
                font.family: ff
                anchors.verticalCenterOffset: -224
                anchors.horizontalCenterOffset: 0
                anchors.centerIn: parent

                PropertyAnimation {
                    id: propertyAnimation
                    target: title
                    property: "opacity";
                    to: 1;
                    duration: 700
                    running: true
                }
                PropertyAnimation {
                    id: slide
                    target: title
                    property: "anchors.horizontalCenterOffset";
                    to: 5;
                    duration: 700
                    running: true
                }
            }

            Text {
                id: subtitle
                width: 407
                height: 82
                opacity: 0
                color: "#ffffff"
                text: qsTr("The Anonymous peer to peer messaging solution")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                font.styleName: "Thin"
                font.weight: Font.Thin
                font.italic: false
                anchors.horizontalCenterOffset: 5
                anchors.centerIn: parent
                font.family: ff
                anchors.verticalCenterOffset: -136
                font.pointSize: 26
                PropertyAnimation {
                    id: fade
                    target: subtitle
                    property: "opacity";
                    to: 1;
                    duration: 1500
                    running: true
                }
            }




            RoundButton {
                id: roundButton
                x: 70
                y: 509
                width: 369
                height: 74
                radius: 30
                text: "Get Started"
                font.pointSize: 30
                font.family: ff
                font.weight: Font.Light
                highlighted: true
                flat: true

                QtObject{
                    id:bu

                    property var wl: if(roundButton){roundButton.down ? "#cf3429":"#000000"}
                    property var op: if(roundButton){roundButton.down ? 0.2:0.1}


                }
                background: Rectangle
                {
                    id:loaddd
                    radius: 30
                    color: bu.wl
                    opacity: bu.op
                }
                onClicked: {
                    if(name !=""){
                        loaddd.color = "#ffffff"
                        logout.running= true
                        mainn.visible = true;
                        mainanii.running= true
                        bridge.login(name)
                    }




                    //login.visible = false;

                }
            }
            Button {
                id: button
                x: 122
                y: 600
                width: 266
                height: 53
                text: qsTr("Load Existing Profile")
                font.hintingPreference: Font.PreferDefaultHinting
                font.weight: Font.ExtraLight
                font.pointSize: 21
                font.family: ff
                highlighted: false
                flat: false
                onPressed:{
                    console.log("load profile")
                }
                QtObject{
                    id:lp
                    property var cl: if(button){button.down ? "#ffffff":"#000000"}
                    property var op: if(button){button.down ? 0.1:0}

                }

                background: Rectangle
                {
                    id:loadd
                    radius: 30
                    color: lp.cl
                    opacity:lp.op
                }
                //                onClicked: {
                //                    loadd.color= button.down ? "#ffffff":"#000000"
                //                    loadd.opacity= 0.2

                //                }

            }

            Rectangle {
                x: 0
                width: 500
                height: 389
                opacity: 0
                radius: 40
                anchors.top: parent.top
                MouseArea {
                    width: parent.width
                    height: parent.height
                    opacity: 1
                    onMouseXChanged: {
                        var dx = mouseX - previousX
                        mainWindow.setX(mainWindow.x + dx)
                    }
                    onPressed: {
                        previousX = mouseX
                        previousY = mouseY
                    }
                    z: 2
                    onMouseYChanged: {
                        var dy = mouseY - previousY
                        mainWindow.setY(mainWindow.y + dy)
                    }
                }
                z: 2
            }
        }}

    Item {
        id: chatt
        opacity: 1
        visible: false


        PropertyAnimation {
            id: chatani
            target: chatt
            property: "opacity"
            to: 1
            duration: 300
            running: false
            from: 0

        }
        PropertyAnimation {
            id: chataniout
            target: chatt
            property: "opacity"
            to: 0
            duration: 300
            running: false
            from: 1

        }

        Rectangle {
            id: back1
            x: 0
            y: 0
            width: 500
            height: 800
            opacity: 1
            visible: true
            color: "#e6ffffff"
            radius: 30
            border.width: -1
            clip: true
            smooth: true
        }

        Item {
            id: item7
            width: 0
            height: 0

            Flickable {
                id:blurgrid
                x: 0
                y: 0
                width: 500
                height: 800
                visible: true
                synchronousDrag: false
                //visible: true
                boundsMovement: Flickable.FollowBoundsBehavior
                //synchronousDrag: false
                boundsBehavior: Flickable.DragAndOvershootBounds
                flickableDirection: Flickable.VerticalFlick


                ListView{
                    id:lv
                    x: 0
                    y: 0
                    width: 500
                    height: 800
                    focus: true
                    rotation: 180
                    orientation: Qt.Vertical
                    model:currentmsgs





                    delegate:Row {
                        rotation: 180
                        x: 20

                        Loader {
                            id: loaderr
                            source: element

                            onLoaded:{


                                loaderr.item.msg= name!="" ? name :loaderr.item.msg

                            }

                        }
                    }

                }



            }}

        Item {
            id: item8
            x: 0
            y: 0
            width: 500
            height: 102
            Rectangle {
                width: 500
                height: 100
                radius: 30
                anchors.fill: fastBlur1
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop {
                        position: 0
                        color: "#00c6ff"
                    }

                    GradientStop {
                        position: 1
                        color: "#0072ff"
                    }
                }
            }

            FastBlur {
                id: fastBlur1
                width: 500
                height: 100
                opacity: 0.55
                radius: 27
                source: ShaderEffectSource {
                    sourceItem: blurgrid
                    sourceRect: Qt.rect(0, 0, fastBlur1.width, fastBlur1.height)
                }
                transparentBorder: true
            }


            Rectangle {
                id: rectangle9
                x: 67
                y: 20
                width: 60
                height: 60
                color: "#30cfd0"
                radius: 30
                gradient: Gradient {
                    GradientStop {
                        position: 0
                        color: c11
                    }

                    GradientStop {
                        position: 1
                        color: c22
                    }
                    orientation: Gradient.Vertical
                }
            }

            Text {
                id: text6
                x: 157
                y: 27
                width: 187
                height: 47
                color: "#ffffff"
                text: messaging
                font.pixelSize: 30
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.family: ff
                font.styleName: "Light"
            }
            Rectangle {
                id: onlineind
                x: 110
                y: 55
                width: 25
                height: 25
                opacity: 0.803
                color: "#ff0000"
                radius: 30
            }

            Button {
                id: backch
                x: 8
                y: 23
                z:4
                width: 53
                height: 53
                text: qsTr("<")
                highlighted: true
                flat: true
                font.family: "Rubik"
                font.pointSize: 38
                visible: false
                //color:"#ffffff"

                font.styleName: "Thin"
                onPressed: {
                    chataniout.running=true
                    backch.visible = false
                    mainani3.running=true
                }
                PropertyAnimation {
                    id:  backchani
                    target:backch
                    property: "opacity"
                    to: 1
                    duration: 1300
                    running: false
                    from: 0
                }
                background: Rectangle {
                    id: loadd1
                    opacity: 0
                    color: "#000000"
                    radius: 30
                }

            }

        }









        Rectangle {
            x: 10
            y: 700
            width: 480
            height: 90
            color: "#0072ff"
            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop {
                    position: 0
                    color: "#00c6ff"
                }

                GradientStop {
                    position: 1
                    color: "#0072ff"
                }
            }
            radius: 20
            anchors.fill: fastBlur2
        }



        FastBlur {
            id: fastBlur2
            x: 10
            y: 700
            width: 480
            height: 90
            opacity: 0.55
            radius: 27
            source: ShaderEffectSource {
                sourceItem: blurgrid
                sourceRect: Qt.rect(10,700, fastBlur2.width, fastBlur2.height)
            }
            transparentBorder: true
        }
        TextInput {
            id: textInput1
            x: 20
            y: 710
            width: 420
            height: 70
            color: "#ffffff"
            text: ""
            font.pixelSize: 28
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
            selectByMouse: true
            activeFocusOnPress: true
            cursorVisible: true
            font.family: ff

            font.styleName: "Light"
            TextMetrics {
                id: tm
                font: textInput1.font
                text: textInput1.text
            }


            Keys.onPressed: {z
                if (event.key == Qt.Key_Return) {
                    if(textInput1.text!=""){
                        currentmsgs.insert(1,{
                                               element: "Bubble.qml",
                                               name:textInput1.text

                                           })


                    }

                    //allmsg = mod

                    textInput1.text = ""



                }}
        }


        Image {
            id: plane
            x: 440
            y: 726
            width: 40
            height: 40
            visible: true
            source: "images/plane.png"
            antialiasing: true
            mipmap: true
            asynchronous: true
            fillMode: Image.PreserveAspectFit
            MouseArea
            {
                width: parent.width
                height: parent.height
                onPressed: {
                    if(textInput1.text!=""){
                        currentmsgs.insert(1,{
                                               element: "Bubble.qml",
                                               name:textInput1.text

                                           })


                    }

                    //allmsg[][] = mod

                    textInput1.text = ""



                }}
        }

        Rectangle {
            x: 76
            width: 424
            height: 100
            opacity: 0
            radius: 40
            anchors.top: parent.top
            MouseArea {
                width: parent.width
                height: parent.height
                opacity: 1
                onMouseXChanged: {
                    var dx = mouseX - previousX
                    mainWindow.setX(mainWindow.x + dx)
                }
                onPressed: {
                    previousX = mouseX
                    previousY = mouseY
                }
                z: 2
                onMouseYChanged: {
                    var dy = mouseY - previousY
                    mainWindow.setY(mainWindow.y + dy)
                }
            }
            z: 2
        }}



    Item{
        id:mainn
        opacity: 1
        visible: false



        PropertyAnimation {
            id:  mainanii
            target:mainn
            property: "opacity"
            to: 1
            duration: 300
            running: false
            from: 0
        }
        PropertyAnimation {
            id:  mainani
            target:mainn
            property: "opacity"
            to: 0
            duration: 300
            running: false
            from: 1

        }
        PropertyAnimation {
            id:  mainani2
            target:mainn
            property: "x"
            to: -500
            duration: 300
            running: false
            from:0

        }
        PropertyAnimation {
            id:  mainani3
            target:mainn
            property: "x"
            to: 0
            duration: 300
            running: false
            from:-500

        }
        Rectangle {
            id: back
            x: 0
            y: 0
            width: 500
            height: 800
            opacity: 1
            visible: true
            color: "#e6ffffff"
            radius: 30
            border.width: -1
            clip:false
            smooth: true
        }

        Item {
            id: item4
            width: 0
            height: 0



            Flickable {
                id: flickable
                property var con
                x: 0
                y: 0
                width: 500
                height: 800
                visible: true
                focus: true

                ScrollBar.vertical: ScrollBar { }
                //                ScrollBar.vertical.interactive: true
                //                 ScrollBar.vertical.policy: ScrollBar.AlwaysOn
                boundsMovement: Flickable.FollowBoundsBehavior
                synchronousDrag: false
                boundsBehavior: Flickable.DragAndOvershootBounds
                flickableDirection: Flickable.VerticalFlick

                ListView{

                    x: 0
                    y: 0
                    width: 500
                    height: 800
                    focus: true
                    orientation: Qt.Vertical
                    model:allcon
                    delegate:Row {

                        Loader {
                            id: loader
                            source: element
                            onLoaded:{ loader.item.msg=name
                                loader.item.c1=c1
                                loader.item.c2=c2}

                        }


                    }
                }
            }
        }



        Item {
            id: item2
            x: 0
            y: 0
            width: 500
            height: 102

            Rectangle {
                anchors.fill: fastBlur
                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop {
                        position: 0
                        color: "#4facfe"
                    }

                    GradientStop {
                        position: 1
                        color: "#00f2fe"
                    }
                }
                width: 500
                height: fastBlur.height
                radius: 30




            }
            FastBlur {
                id: fastBlur
                x:0
                y:0
                height: 100

                width: parent.width
                radius: 27
                opacity: 0.5

                source: ShaderEffectSource {
                    sourceItem: flickable
                    sourceRect: Qt.rect(0, 0, fastBlur.width, fastBlur.height)
                }
                transparentBorder: true
            }

            Rectangle {
                id: rectangle
                x: 21
                y: 20
                width: 60
                height: 60
                color: "#30cfd0"
                radius: 30
                gradient: Gradient {
                    orientation: Gradient.Vertical
                    GradientStop {
                        position: 0
                        color: "#30cfd0"
                    }

                    GradientStop {
                        position: 1
                        color: "#330867"
                    }
                }
            }

            Text {
                id: text1
                x: 101
                y: 27
                width: 187
                height: 47
                color: "#ffffff"
                text: name
                font.pixelSize: 30
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.family: ff
                font.styleName: "Light"
            }


        }








        Rectangle {
            width: 500
            height: 100
            radius: 40
            opacity: 0

            anchors.top: parent.top


            z:2
            MouseArea {
                z:2
                opacity: 1
                width: parent.width
                height: parent.height

                onPressed: {
                    previousX = mouseX
                    previousY = mouseY
                }

                onMouseXChanged: {
                    var dx = mouseX - previousX
                    mainWindow.setX(mainWindow.x + dx)
                }

                onMouseYChanged: {
                    var dy = mouseY - previousY
                    mainWindow.setY(mainWindow.y + dy)
                }

            }

        }


    }


    RoundButton {
        id: exit
        x: 434
        y: 20
        z:3
        width: 20
        height: 20
        visible: true
        radius: 60

        text: "—"
        font.pointSize: 13
        font.family: ff
        layer.mipmap: false
        layer.enabled: false
        layer.format: ShaderEffectSource.RGBA
        focusPolicy: Qt.ClickFocus
        //spacing: 9
        //display: AbstractButton.IconOnly
        clip: false
        highlighted: false
        flat: false
        onClicked:mainWindow.showMinimized()

        QtObject{
            id:buts
            property string colorDefult :"#1f1f1f1f"
            property var dynamicColor: if(exit){
                                           exit.down ? "#f1f1f1f1":colorDefult
                                       }
        }
        background: Rectangle
        {
            radius: 7
            color: buts.dynamicColor
        }



    }

    RoundButton {
        id: roundButton1
        x: 460
        y: 20
        z:3
        width: 20
        height: 20
        visible: true
        radius: 351
        text: "X"
        font.pointSize: 12
        clip: false
        layer.format: ShaderEffectSource.RGBA
        layer.mipmap: false
        flat: false
        font.family: ff
        focusPolicy: Qt.ClickFocus
        //spacing: 9
        highlighted: false
        layer.enabled: false
        onClicked:Qt.quit()
        QtObject{
            id:butsss
            property string colorDefult :"#1f1f1f1f"
            property var dynamicColor: if(roundButton1){
                                           roundButton1.down ? "#f1f1f1f1":colorDefult
                                       }
        }
        background: Rectangle
        {
            radius: 7
            color: butsss.dynamicColor
        }

    }




}



/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.1;height:480;width:640}D{i:3;invisible:true}
D{i:35}D{i:58}D{i:72}
}
##^##*/


