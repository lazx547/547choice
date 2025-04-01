import QtQuick

Rectangle {
    id:root
    width: 200
    height: 40
    radius: 4
    border.width: 1
    border.color: "#80808080"
    enabled: false
    property real interval:5000
    function show(text__,time){
        text_.text=text__
        timer.interval=time
        enabled=true
        root.focus=true
        timer.running=true
    }
    onActiveFocusChanged: {
        if(!root.activeFocus)
            enabled=false
    }

    Timer{
        id:timer
        running: false
        interval: root.interval
        onTriggered: root.enabled=false
    }
    Text{
        id:text_
        anchors.centerIn: parent
        font.pixelSize: 15
        text:""
    }

    NumberAnimation on scale {
        running: root.enabled
        duration: 350
        easing.type: Easing.OutBack
        easing.overshoot: 1.0
        to: 1.0
    }

    NumberAnimation on opacity {
        running: root.enabled
        duration: 300
        easing.type: Easing.OutQuad
        to: 1.0
    }

    NumberAnimation on scale {
        running: !root.enabled
        duration: 300
        easing.type: Easing.InBack
        easing.overshoot: 1.0
        to: 0.0
    }

    NumberAnimation on opacity {
        running: !root.enabled
        duration: 250
        easing.type: Easing.OutQuad
        to: 0.0
    }

}
