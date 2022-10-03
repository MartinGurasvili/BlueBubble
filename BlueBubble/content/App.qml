import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import backend

Window {
    id: mainWindow
    minimumWidth: 300
    minimumHeight: mainWindow.width*1.6
    height:mainWindow.width*1.6
    width:500
    maximumWidth: 800
    maximumHeight: 1280
    
    flags: Qt.Window | Qt.FramelessWindowHint
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
    property var sprite
    property var component;
    property string msg;
    property string pastmsg;
    property var aduserdata :[]
    property var allmsgs : [ ]
    property bool inChat :false
    property bool online :false
    property var currentmsgs:ListModel{}
    property var profilep : []
    property string currentchat:""
    property var allcon:ListModel{}
    property var cont:[]
    property var contIndex:[]
    property var ben:[]

       Bridge {
           id: bridge
       }
    Item {
        id: login
        visible:true
        transform: Scale { xScale: mainWindow.width/500;yScale: mainWindow.width/500}

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
                cont = bridge.LoadListModel("contacts.txt")
                contIndex = bridge.contactIndex(cont)
                for(let i = contIndex[7]-1; i >= 0; i--)
                {
                    allcon.insert(0,{
                                               element:cont[i][contIndex[0]],
                                               name:cont[i][contIndex[1]],
                                                c1:cont[i][contIndex[2]],
                                                c2:cont[i][contIndex[3]],
                                                ip:cont[i][contIndex[4]],
                                                port:cont[i][contIndex[5]],
                                                uport:cont[i][contIndex[6]]
                                           })
                }
                ben = bridge.load_user("")
                console.log(ben[1])
                name = ben[0]
                profilep = [ben[1].toString(),ben[2].toString()]
                print(profilep[0])
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
                            profilep = bridge.colorpicker([])
                            loaddd.color = "#ffffff"
                            logout.running= true
                            mainn.visible = true;
                            mainanii.running= true
                            bridge.login([name,profilep[0],profilep[1]])
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
                            profilep = bridge.colorpicker([])
                            loaddd.color = "#ffffff"
                            logout.running= true
                            mainn.visible = true;
                            mainanii.running= true
                            bridge.login([name,profilep[0],profilep[1]])
                        }}

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
        }

    Item {
        id: chatt
        opacity: 1
        visible: false
        transform: Scale { xScale: mainWindow.width/500;yScale: mainWindow.width/500}
        Timer {
            interval: 1000; running: true; repeat: true
            onTriggered: {
                if(inChat ==true)
                {
                    msg = bridge.checkmessage("")
                    if(msg !="" && msg !=pastmsg ){
                         currentmsgs.insert(1,{
                                               element: "BubbleIn.qml",
                                               name:msg

                                           })
                        bridge.notif(messaging,msg)
                        onlineind.color = "#00FF00"
                        online = true
                        pastmsg = msg
                         msg = ""
                    }
                    if(online == true){
                        onlineind.color = "#00FF00"
                    }
                    
                }
                else{
                    //pastmsg = ""
                    msg = ""
                }
            }
        }


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
                boundsMovement: Flickable.FollowBoundsBehavior
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
                opacity:0.9
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




            Rectangle {
                id: rectangle9
                x: 67
                y: 20
                width: 60
                height: 60
                color: "#30cfd0"
                radius: 30
                opacity:0.9
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
                x: 150
                y: 25
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
                    Text {
                        color: "white"
                        text: qsTr("<")
                        x: 18
                        y: 2
                        width: 53
                        height: 53
                        font.family: "Rubik"
                        font.pointSize: 38
                        font.styleName: "Thin"
                       
                    }
                    flat: true   
                    highlighted: true         
                visible: false
                
                onPressed: {
                    chataniout.running=true
                    backch.visible = false
                    mainani3.running=true
                    inChat =false
                    online = false
                    onlineind.color = "#ff0000"
                    bridge.saveListModel(currentmsgs, currentchat)
                     bridge.exit_chat("")
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
            id:textinputbox
            x: 10
            y: 700
            width: 480
            
            height: (textInput1.text.length<120) ? 90 :(Math.floor(textInput1.text.length/40))*30
            opacity:0.9
            anchors.bottom: parent.bottom
            anchors.bottomMargin:-790
            // anchors.
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
        }


        
        TextInput {
            id: textInput1
            x: 20
            y: 710
            width: 420
            height: textinputbox.height
            color: "#ffffff"
            text: ""
            font.pixelSize: (textInput1.text.length<60) ? 25 : 20
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.verticalCenter: textinputbox.verticalCenter
            wrapMode: Text.Wrap
            selectByMouse: false
            focus:true
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
                        bridge.sendmessage(textInput1.text)

                    }

                    textInput1.text = ""
                    
                }
                }
        }


        Image {
            id: plane
            x: 440
            y: 726
            anchors.verticalCenter: textinputbox.verticalCenter
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
                        bridge.sendmessage(textInput1.text)

                    }

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



    Item {
        id: addUser
        opacity: 1
        visible: false
        transform: Scale { xScale: mainWindow.width/500;yScale: mainWindow.width/500}
        PropertyAnimation {
            id:  aufadein
            target:Rectangle
            property: "opacity"
            to: 1
            duration: 300
            running: false
            from: 0
        }
        PropertyAnimation {
            id:  aufadeout
            target:Rectangle
            property: "opacity"
            to: 0
            duration: 300
            running: false
            from: 1
        }
        PropertyAnimation {
            id:  auviskill
            target:addUser
            property: "visible"
            to: false
            duration: 300
            running: false
            from: true

        }
        property double prog:1.0
        Timer {
            interval: 1000; running: true; repeat: true
            onTriggered: {
                if(addUser.visible == true){
                    var count = parseInt(countdown.text)
                    tform.xScale = count/120
                    countdown.text =  count - 1
                    if(count == 0){
                        uniId.text = bridge.gencode(name)
                        countdown.text = 120
                        tform.xScale = 1.0
                    }
                }
                

            }}

        Item {
            id: item3
            x: 0
            y: 0
            width: 500
            height: 102
            Rectangle {
                x: 0
                y: 0
                width: 500
                height: 800
                opacity: 0.9
                radius: 30
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

                RoundButton {
                    id: roundButton2
                    x: 66
                    y: 696
                    width: 369
                    height: 74
                    radius: 30
                    text: "Add User"
                    highlighted: true
                    flat: true
                    QtObject {
                        id: bu1
                        property var wl: if(roundButton){roundButton.down ? "#cf3429":"#000000"}
                        property var op: if(roundButton){roundButton.down ? 0.2:0.1}
                    }
                    background: Rectangle {
                        id: loaddd1
                        opacity: bu1.op
                        color: bu1.wl
                        radius: 30
                    }
                    onClicked:{
                        if(textInput2.text !=""){
                                aduserdata = bridge.adduser(textInput2.text)
                                var count = 0
                                 
                                while(true){
                                    if(allcon.get(count).element.toString()=="spacer.qml")
                                    {
                                        break
                                    }
                                count+=1
                                }
                            
                                bridge.notif("Added User",aduserdata[1])
                                allcon.insert(count+1,{
                                               element:aduserdata[0],
                                               name:aduserdata[1],
                                                c1:aduserdata[2],
                                                c2:aduserdata[3],
                                                ip:aduserdata[4],
                                                port:aduserdata[5],
                                                uport:aduserdata[6]
                                           })
                                textInput2.text = ""
                                bridge.saveListModel(allcon,"contacts.txt")
                                aufadeout.running = true
                                mainn.visible = true
                                mainanii.running = true
                                auviskill.running = true
                            }
                    }
                    font.pointSize: 30
                    font.weight: Font.Light
                    font.family: ff
                    z: 7
                }

                Text {
                    id: placeholder1
                    x: 52
                    y: 618
                    width: 383
                    height: 41
                    visible: true
                    color: "#cecece"
                    text: "Enter User's Unique ID"
                    font.pixelSize: 30
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: ff
                    font.italic: true
                    font.styleName: "Light"
                }

                TextInput {
                    id: textInput2
                    x: 59
                    y: 620
                    width: 383
                    height: 41
                    color: "#ffffff"
                    text: ids
                    font.pixelSize: 13
                    wrapMode: Text.Wrap
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: ff
                    

                    MouseArea {
                        id: ma1
                        anchors.fill: parent
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 8
                        anchors.leftMargin: 0
                        anchors.topMargin: -8
                        onClicked: {
                            placeholder1.visible= false;
                            ma1.enabled = false;
                            textInput2.selectByMouse =true;
                            textInput2.focus = true;
                            textInput2.selectByMouse = false;
                        }
                        propagateComposedEvents: true
                    }
                    Keys.onPressed: {
                        if (event.key == Qt.Key_Return) {
                            if(textInput2.text !=""){
                                aduserdata = bridge.adduser(textInput2.text)
                                bridge.notif("Added User",aduserdata[1])
                                var count = 0
                                 
                                while(true){
                                    if(allcon.get(count).element.toString()=="spacer.qml")
                                    {
                                        break
                                    }
                                count+=1
                                }
                                allcon.insert(2,{
                                               element:aduserdata[0],
                                               name:aduserdata[1],
                                                c1:aduserdata[2],
                                                c2:aduserdata[3],
                                                ip:aduserdata[4],
                                                port:aduserdata[5],
                                                uport:aduserdata[6]
                                           })
                                textInput2.text = ""
                                bridge.saveListModel(allcon,"contacts.txt")
                                aufadeout.running = true
                                mainn.visible = true
                                mainanii.running = true
                                auviskill.running = true
                            }}
                    }
                    font.styleName: "Light"
                }

                Rectangle {
                    x: 41
                    y: 600
                    opacity: 0.1
                    color: "#000000"
                    radius: 30
                    implicitWidth: 411
                    implicitHeight: 77
                }
            }

            Rectangle {
                id: rectangle1
                x: 125
                y: 94
                width: 250
                height: 250
                color: "#30cfd0"
                radius: 125
                gradient: Gradient {
                    orientation: Gradient.Vertical
                    GradientStop {
                        position: 0
                        color: profilep[0]
                    }

                    GradientStop {
                        position: 1
                        color: profilep[1]
                    }
                }
            }

            Text {
                id: text2
                x: 68
                y: 343
                width: 364
                height: 47
                color: "#ffffff"
                text: name
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: ff
                font.styleName: "Light"
            }

            Text {
                id: text3
                x: 68
                y: 396
                width: 364
                height: 47
                color: "#ffffff"
                text: "Your Unique ID Will Renew in:"
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: ff
                font.styleName: "Light"
            }

            Text {
                id: countdown
                x: 68
                y: 429
                width: 364
                height: 47
                color: "#ffffff"
                text: "30"
                font.pixelSize: 30
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: ff
                font.styleName: "Light"

                Rectangle {
                    id: progbar
                    x: 7
                    y: 53
                    width: 350
                    height: 15
                    color: "#ffffff"
                    radius: 300

                    transform: Scale {
                        id: tform
                        origin.x:175 ;
                        xScale: 1.0
                    }

                    transformOrigin: Item.Center
                    antialiasing: true
                    gradient: Gradient {
                        orientation: Gradient.Vertical
                        GradientStop {
                            position: 0
                            color: "#f093fb"
                        }

                        GradientStop {
                            position: 1
                            color: "#f5576c"
                        }
                    }
                }
            }

            TextEdit {
                id: uniId
                x: 33
                y: 500
                width: 435
                height: 99
                readOnly: true
                color: "#ffffff"
                text: "ZPqAPESu_Q3brbmHhphR67htGIV9aDKBiEJFFC7eVuK7mCE5NQfM5wmcCtoP7fIBypF6nQWTnILaCKB--gCuiW8XsCVgYSwU_K0kjfZ8mwlu0"
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.Wrap
                font.family: ff
                font.styleName: "Light"
                selectByMouse: true
            }
        }

        Button {
            id: backmain
            x: 8
            y: 23
            z: 7
            width: 53
            height: 53
            highlighted: true
            flat: true
            onClicked: {
                aufadeout.running = true
                mainn.visible = true
                mainanii.running = true
                auviskill.running = true

            }

            Text {
                x: 18
                y: 2
                z: 7
                width: 53
                height: 53
                color: "#ffffff"
                text: qsTr("<")
                font.family: "Rubik"
                font.pointSize: 38
                font.styleName: "Thin"
            }
            background: Rectangle {
                id: loadd2
                opacity: 0
                color: "#000000"
                radius: 30
            }

        }

        Rectangle {
            x: 57
            width: 443
            height: 100
            opacity: 0
            radius: 40
            anchors.top: parent.top
            z: 2
            MouseArea {
                width: parent.width
                height: parent.height
                opacity: 1
                z: 2
                onMouseXChanged: {
                    var dx = mouseX - previousX
                    mainWindow.setX(mainWindow.x + dx)
                }
                onMouseYChanged: {
                    var dy = mouseY - previousY
                    mainWindow.setY(mainWindow.y + dy)
                }
                onPressed: {
                    previousX = mouseX
                    previousY = mouseY
                }
            }
        }

    }

    Item{
        id:mainn
        opacity: 1
        visible: false
        transform: Scale { xScale: mainWindow.width/500;yScale: mainWindow.width/500}


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
            id:  viskill
            target:mainn
            property: "visible"
            to: false
            duration: 300
            running: false
            from: true

        }
        PropertyAnimation {
            id:  mainani2
            target:mainn
            property: "x"
            to: -1000
            duration: (300/mainWindow.width)*400
            running: false
            from:0

        }
        PropertyAnimation {
            id:  mainani3
            target:mainn
            property: "x"
            to: 0
            duration: (300/mainWindow.width)*400
            running: false
            from:-1000

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



        Rectangle {
            width: 500
            height: 100
            radius: 40
            opacity: 0

            anchors.top: parent.top


            z:2
            MouseArea {
                x: 80
                y: 0
                width: 420
                z:2
                opacity: 1
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

        Item {
            id: item2
            x: 0
            y: 0
            width: 500
            height: 102

            Rectangle {
                opacity:0.9
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
                height: 100
                radius: 30




            }
            

            Button {
                id: rectangle
                x: 21
                y: 20
                z:9999999

                width: 60
                height: 60
                opacity: 0
                clip: true

                onClicked: {
    
                    uniId.text = bridge.gencode(name)
                    countdown.text = 60
                    mainani.running = true
                    viskill.running = true
                    addUser.visible = true
                    aufadein.running = true
    
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

            Rectangle{
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
                        color: profilep[0]
                    }

                    GradientStop {
                        position: 1
                        color: profilep[1]
                    }
                }}


        }

    }

    Item{
        transform: Scale { xScale: mainWindow.width/500;yScale: mainWindow.width/500}
    RoundButton {
        id: exit
        x: 434
        y: 20
        z:3
        width: 20
        height: 20
        visible: true
        radius: 60
        
        Text {
            color: "white"
            text: "—"
            font.pointSize: 13
            font.family: ff
            anchors.verticalCenter: parent.verticalCenter
            x:3

        }
        
        layer.mipmap: false
        layer.enabled: false
        layer.format: ShaderEffectSource.RGBA
        focusPolicy: Qt.ClickFocus
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
        Text {
            color: "white"
            text: "X"
            font.pointSize: 12
            font.family: "Rubik"

            x:6
            y:3

        }
        clip: false
        layer.format: ShaderEffectSource.RGBA
        layer.mipmap: false
        flat: false
        focusPolicy: Qt.ClickFocus
        //spacing: 9
        highlighted: false
        layer.enabled: false
        onClicked:{
            Qt.quit()
            bridge.quit("")
            
            
        }
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
    




}


