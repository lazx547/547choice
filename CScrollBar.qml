import QtQuick
import QtQuick.Controls
import QtQuick.Window

Item{
    height: 20
    id:pickerItem
    property real value:slider.value
    property real maxValue:100
    property real minValue:0
    property string text
    property real step:0.01
    onTextChanged: text_.text=text
    function setValue(vl){
        slider.x = Math.max(0,vl*(pickerItem_.width-slider.width))
    }
    Text{
        id:text_
        text:text
        font.pixelSize: 18
        y:-2
    }
    DelButton{
        x:30
        radiusBg:0
        width: 10
        height: pickerItem.height
        text:"<"
        font.pixelSize: 10
        padding: 0
        topPadding: 0
        bottomPadding: 0
        onClicked: setValue(value-step)
    }
    DelButton{
        id:bur
        x:175
        radiusBg:0
        width: 10
        height: pickerItem.height
        text:">"
        font.pixelSize: 10
        padding: 0
        topPadding: 0
        bottomPadding: 0
        onClicked: setValue(value+step)
    }
    Item {
        id: pickerItem_
        width: 135
        height: pickerItem.height
        x:40
        y:0
        Rectangle {
            anchors.fill: parent
            border.color: "#80808080"
            border.width: 2
            ToolTip.visible: false
        }
        Rectangle {
            id: slider
            x: parent.width - width
            width: height
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            border.color: pickerItem_.down ? "#1677ff" : pickerItem_.hovered ? "#69b1ff" : "#80808080";
            border.width: 2
            scale: 0.9
            property real value: x / (pickerItem_.width - width)
            Behavior on scale { NumberAnimation { easing.type: Easing.OutBack; duration: 300 } }
        }

        MouseArea {
            anchors.fill: parent

            function handleCursorPos(x) {
                let halfWidth = slider.width * 0.5;
                slider.x = Math.max(0, Math.min(width, x + halfWidth) - slider.width);
            }

            onReleased: slider.scale = 0.9;
            onPressed: (mouse) => {
                           slider.scale=0.6
                           handleCursorPos(mouse.x, mouse.y);
                       }
            onPositionChanged: (mouse) => handleCursorPos(mouse.x);
        }
    }
    Rectangle{
        id:shvr
        x:185
        y:0
        z:-1
        width: 35
        height: pickerItem.height
        color:Qt.rgba(0.8,0.8,0.8)
        Text{
            anchors.fill: parent
            id:vr
            text:(slider.value * (maxValue-minValue)).toFixed(0)
            font.pixelSize: 14
            horizontalAlignment:Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}
