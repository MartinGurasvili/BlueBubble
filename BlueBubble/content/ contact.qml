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
    property var time:(new Date().toLocaleString(Qt.locale()).split(/[, ]+/))
    property var temp:ListModel{
                           id: mod
                           ListElement{
                               element: "bspacer.qml"
                               name:" "
                               }
                        
                           ListElement{
                               element: "time.qml"
                               name:""
                               }
                            
                           
                           
                           }
    property var msgIndex:[]
    property var cont:[]
    MouseArea
    {
        width: parent.width
        height: parent.height
//        onPressAndHold:console.log("darg")

        onClicked: {
            time = time[0]+" "+time[1]
            currentchat = msg
            if(temp.count == 2){
                console.log(time)
                temp.setProperty(1, "name", time);
                cont = bridge.LoadListModel(msg)
                if (cont[0] != -1 ){
                    bridge.saveListModel(temp, msg)
                    msgIndex = bridge.messageIndex(cont)
                    if(msgIndex[2]-1 >2)
                    {
                        for(let i = msgIndex[2]-1; i >=2 ; i--)
                        {
                            temp.insert(2,{
                                                    element:cont[i][msgIndex[0]],
                                                    name:cont[i][msgIndex[1]],
                                                })
                        }
                    }
                }
            }
            inChat =true
            mainani2.running= true
            //mainani.running= true

            chatt.visible= true
            backchani.running= true
            chatani.running= true
            backch.visible = true
            c11=cll1.color
            c22 =cll2.color
            messaging = text3.text
            var inlist = false
            var where = false
            textInput1.selectByMouse =true;
            textInput1.focus = true;
            textInput1.selectByMouse = false;
            

            for(var x = 0;x<allmsgs.length;x++)
            {
                if(allmsgs[x][0]==text3.text)
                {
                    inlist = true
                    where = x
                }
            }
            if(inlist == true)
            {

               currentmsgs = allmsgs[where][1]

            }
            else{
                allmsgs.push([text3.text,temp])
                currentmsgs = temp
            }

            bridge.message([ip,port,uport])
            
            var count = 0
             while(true){
                if(allcon.get(count).element.toString()=="element")
                {
                    break
                }
            count+=1
            }
    
            for(var y = 1;y<allcon.count;y++)
            {

                if(allcon.get(y).name.toString()==text3.text)
                {

                    allcon.move(y,count-1,1)
                }
            }
            


            
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
        color: "#ff0000"
        radius: 30
        gradient: Gradient {
            orientation: Gradient.Vertical
            GradientStop {
                id:cll1
                position: 0
                color:c1
            }

            GradientStop {
                position: 1
                id:cll2
                color:c2
            }
        }
    }

    Text {
        id:text3
        x: 101
        y: 27
        width: 187
        height: 47
        color: "#a9a9a9"
        text: msg
        font.pixelSize: 30
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        font.styleName: "Light"
        font.family: ff
    }
}
