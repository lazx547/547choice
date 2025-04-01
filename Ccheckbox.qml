import QtQuick
import QtQuick.Controls

Item {
    id: control
    property bool animationEnabled: true
        property bool effectEnabled: true
    property int radiusBg: 6
    property color colorText:"#000000"
    property color colorBg: checked? "#2955ff":"white";
    property color colorBorder:control.down ? "#000" : control.hovered ? "#69b1ff" : "#80808080";
    property string contentDescription: text
    property bool checked:false
    property bool checked_:false
    property string text
    onTextChanged: text_.text=text
    onWidthChanged: text_.width=control.width-control.height-5
    onHeightChanged: {
        text_.width=control.width-control.height-5
        text_.height==control.height
        border_.width=border_.height=height-2
    }
    onCheckedChanged: colorBg=checked? "#2955ff":"white";
    onChecked_Changed: colorBg=checked? "#2955ff":"white";

    Text {
        width: control.width-control.height-5
        height: control.height
        x:border_.width+5
        id: text_
        text: text
        font.pixelSize: 16
        color: "#000000"
        Behavior on color{ NumberAnimation {duration: 300 } }
    }
    Rectangle{
        x:1
        y:1
        id:border_
        width: control.height-2
        height: control.height-2
        border.color: colorBorder
        border.width: 1
        radius: 6
        color: colorBg
        Behavior on color{ NumberAnimation {duration: 300 } }
    }
    MouseArea{
        id:mouse
        property bool hovered:false
        anchors.fill: parent
        hoverEnabled: true
        onClicked: checked=!checked
        onEntered: {
            border_.border.color="#1677ff"
            text_.color="#1677ff"
        }
        onExited: {
            border_.border.color="#000"
            text_.color="#000000"
        }
    }
    Accessible.role: Accessible.RadioButton
    Accessible.name: control.contentDescription
    Accessible.description: control.contentDescription
    Accessible.onPressAction: control.clicked();
}
