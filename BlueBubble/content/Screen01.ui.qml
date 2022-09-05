

/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import BlueBubble
import QtQuick.Controls.macOS 6.0
import Qt5Compat.GraphicalEffects

Rectangle {
    id: backk
    width: 500
    height: 800
    opacity: 1

    smooth: true
    visible: true
    color: "#e65ee7df"
    //color: "#00000000"
    radius: 30
    border.width: -1
    gradient: Gradient {
        orientation: Gradient.Vertical
        GradientStop {
            position: 0
            color: "#00c6ff"
        }

        GradientStop {
            position: 1
            color: "#0072ff"
        }

        GradientStop {
            position: 0
            color: "#00c6ff"
        }
    }

    Image {
        id: back1
        x: 3
        y: 0
        opacity: 0.1
        width: 500
        height: 800
        smooth: true
        fillMode: Image.PreserveAspectCrop
        source: backk
    }

    Text {
        id: placeholder
        x: 56
        y: 413
        width: 383
        height: 41
        color: "#b7b7b7"
        text: inputHandler.pressed ? " " : "Enter Username"
        font.pixelSize: 25
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Courier"
    }

    TextInput {
        id: textInput
        x: 56
        y: 413
        width: 383
        height: 41
        color: "#ffffff"
        text: qsTr("")
        font.pixelSize: 25
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Courier"
    }
    Rectangle {
        x: 45
        y: 395
        implicitWidth: 411
        implicitHeight: 77
        radius: 30
        color: "#000000"
        opacity: 0.1

        //        TextField {
        //            id: textField
        //            x: 0
        //            y: 0

        //            width: 411
        //            height: 77
        //            opacity: 1
        //            color: "#fff"
        //            font.pixelSize: 30
        //            font.family: "Courier"
        //            placeholderText: qsTr("Enter Username")
        //            anchors.left:label.right
        //            anchors.leftMargin: 10
        //            anchors.verticalCenter: label.verticalCenter
        //            horizontalAlignment: TextInput.AlignHCenter

        //        }
    }

    //    TextField {
    //        id: textInput
    //        x: 50
    //        y: 419
    //        width: 411
    //        height: 77
    //        color: "#fff"
    //        font.pixelSize: 30

    //        horizontalAlignment: Text.AlignHasfCenter
    //        verticalAlignment: Text.AlignVCenter
    //        placeholderText : "Enter Username"
    //        placeholderTextColor: "#d2d2d2"
    //        selectionColor: "#b9c6ef"
    //        font.family: "Courier"
    //        wrapMode: Text.WordWrap
    //        background: Rectangle
    //        {
    //            radius: 30
    //            color: "#000000"
    //            opacity:0.1
    //        }

    //    }
    FastBlur {
        anchors.fill: back1
        source: back1
        anchors.rightMargin: -3
        anchors.bottomMargin: 0
        anchors.leftMargin: 3
        anchors.topMargin: 0
        radius: 40
        opacity: 1
    }

    Text {
        id: title
        width: 342
        height: 82
        opacity: 0
        color: "#ffffff"
        text: "Welcome To Blue Bubble"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: true
        font.pointSize: 33
        font.family: "Courier"
        anchors.verticalCenterOffset: -283
        anchors.horizontalCenterOffset: -10
        anchors.centerIn: parent

        PropertyAnimation {
            id: propertyAnimation
            target: title
            property: "opacity"
            to: 1
            duration: 700
            running: true
        }
        PropertyAnimation {
            id: slide
            target: title
            property: "anchors.horizontalCenterOffset"
            to: 5
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
        text: qsTr("The Anonymouse peer to peer messaging solution")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
        font.italic: false
        anchors.horizontalCenterOffset: 5
        anchors.centerIn: parent
        font.family: "Courier"
        anchors.verticalCenterOffset: -195
        font.pointSize: 23
        PropertyAnimation {
            id: fade
            target: subtitle
            property: "opacity"
            to: 1
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
        font.family: "Courier"
        highlighted: true
        flat: true
        background: Rectangle {
            radius: 30
            color: "#000000"
            opacity: 0.1
        }
    }
    Button {
        id: button
        x: 122
        y: 605
        width: 266
        height: 53
        text: qsTr("Load Existing Profile")
        font.hintingPreference: Font.PreferDefaultHinting
        font.weight: Font.ExtraLight
        font.pointSize: 19
        font.family: "Courier"
        highlighted: true
        background: Rectangle {
            radius: 30
            color: "#000000"
            opacity: 0
        }
    }
}
