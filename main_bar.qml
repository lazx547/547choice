import QtQuick
import DelegateUI.Controls 1.0
import QtQuick.Window
import Qt.labs.platform
import GFile 1.2

Window {
    id: window
    minimumHeight: 50
    maximumHeight: 50
    minimumWidth: 50
    maximumWidth: 50
    visible:true
    width: 50
    height: 50
    flags:Qt.FramelessWindowHint|Qt.WindowStaysOnTopHint
    x:x>(sys_width-window.width)? (sys_width-width):0
    y:sys_height/2-25
    color: Qt.rgba(0,0,0,0)

    readonly property real sys_width: window.screen.width
    readonly property real sys_height: window.screen.height
    property int dragX: 0
    property int dragY: 0
    property bool dragging: false
    property int x0
    property int y0
    property var a:[]
    property int sim
    property bool none:false

    GFile{
        id:file
    }

    Component.onCompleted: {
        file.source="./source_.ini"
        if(file.is("./source_.ini"))
        {
            var s=file.read()
            var i=0,l=s.length,j=0
            do
            {
                a.push(s.slice(0,s.indexOf(",")))
                i=s.indexOf(",")+1
                s=s.slice(i,l)
                j++
            }
            while(i!=0)
            sim=j-1
        }
        else
        {
            none=true
        }
    }
    function cou(){
        var b=Math.floor(Math.random() * sim)+1
        return a[b-1]
    }
    SystemTrayIcon {//托盘图标
        visible: true
        icon.source: "qrc:/547rand.ico"
        id:tray
        onActivated:(reason)=>{
                        if(reason==SystemTrayIcon.Trigger)
                        {
                            win.show()
                        }
                    }
        menu:Menu{
            MenuItem{
                text: "抽号"
                onTriggered: {
                    win.visible=false
                    win2.show(1)
                }
            }
            MenuItem{
                text: "隐藏"
                checkable: true
                checked: false
                onTriggered: window.visible=!checked
            }
            MenuItem{
                text: "退出"
                onTriggered: Qt.quit()
            }
        }
    }
    Rectangle{
        anchors.fill: parent
        border.color: "#80808080"
        border.width: 5
        color: Qt.rgba(1,1,1,0.5)
        radius: 5
        Text{
            anchors.fill: parent
            text:"抽号"
            font.pixelSize: 15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
    MouseArea {
        anchors.fill: parent
        onPressed: {
            window.dragX = mouseX
            window.dragY = mouseY
            window.dragging = true
            window.x0=window.x
            window.y0=window.y
        }
        onReleased: {
            window.dragging = false
            if(window.x==window.x0 && window.y==window.y0)
            {
                if(none){
                    data.text="错误"
                    win2.show(0)
                }
                else{
                    win2.hide()
                    win3.hide()
                    win.show()
                }
            }
            else{
                if(window.x<(sys_width-window.width)/2)
                {
                    window.x=0
                }
                else
                {
                    window.x=sys_width-width
                }
                if(window.y<0)
                    window.y=0
                else if(window.y>sys_height-height)
                    window.y=sys_height-height
            }


        }
        onPositionChanged: {
            if (window.dragging) {
                window.x += mouseX - window.dragX
                window.y += mouseY - window.dragY
            }
        }
    }

    Window{
        id:win
        flags:Qt.FramelessWindowHint|Qt.WindowStaysOnTopHint|Qt.Window
        width: 300
        height: 200
        x:sys_width/2-width/2
        y:sys_height/2-height/2
        color:Qt.rgba(0,0,0,0)
        function show(){
            win.x=sys_width/2-win.width/2
            win.y=sys_height/2-win.height/2
            win.visible=true
            win_r.enabled=true
        }
        function hide(){
            win_r.enabled=false
        }
        Rectangle{
            id:win_r
            anchors.fill: parent
            radius: 15
            border.color: Qt.rgba(0.5,0.5,0.5,0.5)
            border.width: 2
            opacity:0
            scale:0
            enabled:false
            NumberAnimation on scale {
                running: win_r.enabled
                duration: 350
                easing.type: Easing.OutCubic
                easing.overshoot: 1.0
                to: 1.0
            }

            NumberAnimation on opacity {
                running: win_r.enabled
                duration: 300
                easing.type: Easing.OutQuad
                to: 1.0
            }

            NumberAnimation on scale {
                running: !win_r.enabled
                duration: 300
                easing.type: Easing.InCubic
                onStopped: win.visible=false
                easing.overshoot: 1.0
                to: 0.0
            }

            NumberAnimation on opacity {
                running: !win_r.enabled
                duration: 250
                easing.type: Easing.OutQuad
                to: 0.0
            }
            Item{
                x:2
                y:2
                Text{
                    text:"抽号"
                    font.pixelSize: 20
                    x:10
                    y:5
                }
                DelButton{
                    x:268
                    y:3
                    width: 25
                    height: 25
                    shape: DelButtonType.Shape_Circle+1
                    type:DelButtonType.Type_Exit+1
                    text: "×"
                    font.pixelSize: 20
                    padding: 0
                    topPadding: 5
                    onClicked: {
                        win.hide()
                    }
                }

                Text{
                    text:"请选择目标人数"
                    width: 300
                    height: 20
                    y:35
                    font.pixelSize: 15
                    horizontalAlignment: Text.AlignHCenter+1
                    verticalAlignment: Text.AlignVCenter+1
                }
                DelButton{
                    x:50
                    y:70
                    width: 40
                    height: 40
                    shape: DelButtonType.Shape_Circle+1
                    type:DelButtonType.Type_Filled+1
                    text: "1"
                    onClicked: {
                        win.hide()
                        win2.show(1,true)
                    }
                }
                DelButton{
                    x:125
                    y:70
                    width: 40
                    height: 40
                    shape: DelButtonType.Shape_Circle+1
                    type:DelButtonType.Type_Filled+1
                    text: "2"
                    onClicked: {
                        win.hide()
                        win2.show(2,true)
                    }
                }
                DelButton{
                    x:200
                    y:70
                    width: 40
                    height: 40
                    shape: DelButtonType.Shape_Circle+1
                    type:DelButtonType.Type_Filled+1
                    text: "3"
                    onClicked: {
                        win.hide()
                        win2.show(3,true)
                    }
                }
                DelButton{
                    x:50
                    y:130
                    width: 40
                    height: 40
                    shape: DelButtonType.Shape_Circle+1
                    type:DelButtonType.Type_Filled+1
                    text: "4"
                    onClicked: {
                        win.hide()
                        win2.show(4,true)
                    }
                }
                DelButton{
                    x:125
                    y:130
                    width: 40
                    height: 40
                    shape: DelButtonType.Shape_Circle+1
                    type:DelButtonType.Type_Filled+1
                    text: "5"
                    onClicked: {
                        win.hide()
                        win2.show(5,true)
                    }
                }
                DelButton{
                    x:200
                    y:130
                    width: 40
                    height: 40
                    shape: DelButtonType.Shape_Circle+1
                    type:DelButtonType.Type_Filled+1
                    text: "6"
                    onClicked: {
                        win.hide()
                        win2.show(6,true)
                    }
                }
            }

        }
        DragHandler {//按下拖动以移动窗口
            grabPermissions: TapHandler.CanTakeOverFromAnything
            onActiveChanged: {
                if (active)
                {
                    win.startSystemMove()
                }
            }
        }
    }
    Window{
        id:win2
        flags:Qt.FramelessWindowHint|Qt.WindowStaysOnTopHint|Qt.Window
        width: 300
        height: 200
        x:sys_width/2-width/2
        y:sys_height/2-height/2
        color:Qt.rgba(0,0,0,0)
        property int num
        property var name:[]
        Component.onCompleted: {
            for(var i=0;i<=6;i++)
                name.push("")
        }

        function show(n,i){
            if(n>0)
            {
                num=n
                data.text=name[0]=cou()
                for(n--;n>0;n--)
                {
                    data.text+=n%2==0? "\n":" "
                    name[num-n]=cou()
                    data.text+=name[num-n]
                }
            }
            if(i){
                win2.x=sys_width/2-width/2
                win2.y=sys_height/2-height/2
            }
            win2.visible=true
            win2_r.enabled=true
        }
        function hide(){
            win2_r.enabled=false
        }
        Rectangle{
            id:win2_r
            anchors.fill: parent
            radius: 15
            border.color: Qt.rgba(0.5,0.5,0.5,0.2)
            border.width: 2
            opacity:0
            scale:0
            enabled:false
            NumberAnimation on scale {
                running: win2_r.enabled
                duration: 350
                easing.type: Easing.OutCubic
                easing.overshoot: 1.0
                to: 1.0
            }
            NumberAnimation on opacity {
                running: win2_r.enabled
                duration: 300
                easing.type: Easing.OutQuad
                to: 1.0
            }
            NumberAnimation on scale {
                running: !win2_r.enabled
                duration: 300
                easing.type: Easing.InCubic
                onStopped: win2.visible=false
                easing.overshoot: 1.0
                to: 0.0
            }
            NumberAnimation on opacity {
                running: !win2_r.enabled
                duration: 250
                easing.type: Easing.OutQuad
                to: 0.0
            }
            Item{
                x:2
                y:2
                Text{
                    text:"抽号"
                    font.pixelSize: 20
                    x:10
                    y:5
                }
                DelButton{
                    x:268
                    y:3
                    width: 25
                    height: 25
                    shape: DelButtonType.Shape_Circle+1
                    type:DelButtonType.Type_Exit+1
                    text: "×"
                    font.pixelSize: 20
                    padding: 0
                    topPadding: 5
                    onClicked: {
                        data.text=""
                        win2.hide()
                    }
                }
                DelButton{
                    x:238
                    y:3
                    width: 25
                    height: 25
                    shape: DelButtonType.Shape_Circle+1
                    text: "-"
                    font.pixelSize: 25
                    padding: 0
                    topPadding: 5
                    onClicked: {
                        win2.hide()
                        win3.show()
                    }
                }
                Text{
                    id:data
                    text:"林雄经"
                    font.pixelSize: 25
                    width: 300
                    height: 20
                    y:80
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                DelButton{
                    x:85
                    y:150
                    width: 130
                    height: 25
                    type:DelButtonType.Type_Primary+1
                    text: "重新抽号"
                    font.pixelSize: 18
                    radiusBg: 13
                    onClicked: {
                        win2.show(win2.num,false)
                    }
                }
            }

        }
        DragHandler {//按下拖动以移动窗口
            grabPermissions: TapHandler.CanTakeOverFromAnything
            onActiveChanged: {
                if (active)
                {
                    win2.startSystemMove()
                }
            }
        }
    }
    Window{
        id:win3
        flags:Qt.FramelessWindowHint|Qt.WindowStaysOnTopHint|Qt.Window
        width: 170
        height: 30
        x:sys_width/2-width/2
        y:sys_height/2-height/2
        color:Qt.rgba(0,0,0,0)
        property int dragX: 0
        property int dragY: 0
        property bool dragging: false
        property int x0
        property int y0
        function show(){
            data2.text=data.text
            win3.x=sys_width/2-width/2
            win3.y=sys_height/2-height/2
            win3.visible=true
            win3_r.enabled=true
        }
        function hide(){
            win3_r.enabled=false
        }
        MouseArea {
            anchors.fill: parent
            onPressed: {
                win3.dragX = mouseX
                win3.dragY = mouseY
                win3.dragging = true
                win3.x0=win3.x
                win3.y0=win3.y
            }
            onReleased: {
                win3.dragging = false
                if(win3.x==win3.x0 && win3.y==win3.y0)
                {
                    win3.hide()
                    win2.show(-1,false)
                }
            }
            onPositionChanged: {
                if (win3.dragging) {
                    win3.x += mouseX - win3.dragX
                    win3.y += mouseY - win3.dragY
                }
            }
        }
        Rectangle{
            id:win3_r
            anchors.fill: parent
            radius: 15
            border.color: Qt.rgba(0.5,0.5,0.5,0.2)
            border.width: 2
            opacity:0
            scale:0
            enabled:false
            NumberAnimation on scale {
                running: win3_r.enabled
                duration: 350
                easing.type: Easing.OutCubic
                easing.overshoot: 1.0
                to: 1.0
            }
            NumberAnimation on opacity {
                running: win3_r.enabled
                duration: 300
                easing.type: Easing.OutQuad
                to: 1.0
            }
            NumberAnimation on scale {
                running: !win3_r.enabled
                duration: 300
                easing.type: Easing.InCubic
                onStopped: win3.visible=false
                easing.overshoot: 1.0
                to: 0.0
            }
            NumberAnimation on opacity {
                running: !win3_r.enabled
                duration: 250
                easing.type: Easing.OutQuad
                to: 0.0
            }
            Item{
                Text{
                    id:data2
                    width: 120
                    height: 26
                    x:13
                    text:""
                    font.pixelSize: 22
                    verticalAlignment: Text.AlignVCenter
                    onTextChanged: {
                        if(win2.num>1)
                            data2.text=win2.name[0]+"……"
                    }
                }

                DelButton{
                    x:143
                    y:2.5
                    width: 25
                    height: 25
                    shape: DelButtonType.Shape_Circle+1
                    type:DelButtonType.Type_Exit+1
                    text: "×"
                    font.pixelSize: 20
                    padding: 0
                    topPadding: 5
                    onClicked: {
                        data2.text=data.text=""
                        win3.hide()
                    }
                }
            }
        }
    }
}
