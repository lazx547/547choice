import QtQuick
import QtQuick.Controls
import QtQuick.Window
import GFile
import QtQuick.Dialogs
import QtQuick.Controls.Basic

ApplicationWindow {
    id: window
    flags: Qt.FramelessWindowHint|Qt.Window
    visible:true
    width: 584
    height: 334
    color: "#00000000"
    title: "547抽号器"
    property int sumn:0//所抽的序号
    property int nummm: 1
    property int sim
    property int cclass:0
    property var a:[]
    property var clas:[]
    property var num_xh:[]
    property var clas_name:[]
    property var clas_objs:[]
    property var obj:Qt.createComponent("./SourceItem.qml")

    property int thisn
    property int thistype
    property string path:"."
    property int thisnum

    onCclassChanged:
    {
        reEnable()
    }
    function reEnable(){
        if(num_xh[cclass]==-1)
        {
            mesenge2.show("已选择\""+clas_name[cclass]+"\""+",没有学号",3000)
            qb.checked=true
            qb.enabled=false
            xh.enabled=false
            mz.enabled=false
        }
        else
        {
            mesenge2.show("已选择\""+clas_name[cclass]+"\"",3000)
            qb.enabled=true
            xh.enabled=true
            mz.enabled=true
        }
    }


    Component.onCompleted:  {
        load()
    }
    onThisnumChanged:
        title="547抽号器("+thisnum+")"
    function load(){
        file.source=path+"/source/.ini"
        if(file.is(path+"/source/.ini"))
        {
            file.source=path+"/source/.ini"
            var s=file.read()
            var i=0,l=s.length,j=0,k,p
            do
            {
                p=s.slice(0,s.indexOf(","))
                clas.push(p)
                i=s.indexOf(",")+1
                s=s.slice(i,l)
            }
            while(i!=0)
            clas.pop()
            for(k=0;k<clas.length;k++)
            {
                file.source=path+"/source/"+clas[k]+".ini"
                s=file.read()
                clas_name.push(s.slice(0,s.indexOf(",")))
                i=s.indexOf(",")+1
                s=s.slice(i,s.length)
                num_xh.push(s.slice(0,s.indexOf(",")))
                i=s.indexOf(",")+1
                s=s.slice(i,s.length)
                a.push([])
                do
                {
                    try{
                        a[k].push(s.slice(0,s.indexOf(",")))
                    }
                    catch(TypeError){
                        p=1
                        break
                    }
                    i=s.indexOf(",")+1
                    s=s.slice(i,s.length)
                }
                while(s.indexOf(",")!=-1)
                clas_objs.push(obj.createObject(clasItem))
                clas_objs[k].name=clas_name[k]
                clas_objs[k].per=window
                clas_objs[k].num=a[k].length
                clas_objs[k].y=k*41
                clas_objs[k].n=k
                clasItem_sv.contentHeight=82*(k+1)
            }
            mesenge.show("已找到"+k+"个班级"+",已选择\""+clas_name[cclass]+"\"",3000)
            reEnable()
        }
        else
        {
            mesenge.show("未找到文件",3000)
            c1.enabled=false
            cn.enabled=false
        }
    }

    function cou(){
        var a=coul()
        if(xh.checked)
            a=a.slice(0,num_xh[cclass])
        else if(mz.checked)
            a=a.slice(num_xh[cclass],a.length)
        return a
    }

    function coul(){
        var b=Math.floor(Math.random() * a[cclass].length)
        return a[cclass][b]
    }
    Window {
        id: win_s
        flags: Qt.FramelessWindowHint|Qt.Window
        visible:false
        width: 304
        height: 334
        color: "#00000000"
        title: window.title+">设置"
        GMesenger{
            id:mesenge2
            z:46578
            width: parent.width-20
            x:20
            y:20
            onFocusChanged: {
                if(!mesenge2.focus)
                    mesenge2.enabled=false
            }
        }
        Rectangle{
            anchors.fill: parent
            border.color: "#80808080"
            border.width: 2
        }
        Item{
            x:2
            y:2
            Rectangle{
                width: win_s.width-4
                height: 30
                color:"#BBBBBB"
                Image{
                    source:"qrc:/547rand.ico"
                    width: 30
                    height: 30
                }
                Text{
                    x:32
                    y:2
                    text:window.title+">设置"
                    font.pixelSize: 20
                }
                DelButton{
                    x:win_s.width-36
                    y:-3
                    width: 30
                    height: 30
                    text: "×"
                    colorBg: "#00000000"
                    colorBorder: "#00000000"
                    font.pixelSize: 30
                    padding: 0
                    type:6
                    topPadding: 8
                    onClicked: {
                        win_s.visible=false
                    }
                }
                Item{
                    width: win_s.width-36
                    height: 30
                    MouseArea {
                        anchors.fill: parent
                        property int dragX
                        property int dragY
                        property bool dragging
                        onPressed: {
                            dragX = mouseX
                            dragY = mouseY
                            dragging = true
                        }
                        onReleased: {
                            dragging = false
                        }
                        onPositionChanged: {
                            if (dragging) {
                                win_s.x += mouseX - dragX
                                win_s.y += mouseY - dragY
                            }
                        }
                    }
                }
            }
            Item{
                y:30
                ScrollView{
                    id:clasItem_sv
                    transformOrigin: Item.TopLeft
                    width: 600
                    height: 600
                    scale:0.5
                    ScrollBar.vertical.policy: ScrollBar.AlwaysOn
                    Rectangle{
                        transformOrigin: Item.TopLeft
                        id:clasItem
                        scale: 2
                        width: 300
                    }
                }
            }
        }
    }
    GMesenger{
        id:mesenge
        z:46578
        width: parent.width-40
        x:20
        y:20
        onFocusChanged: {
            if(!mesenge.focus)
                mesenge.enabled=false
        }
    }

    MouseArea{
        anchors.fill: parent
        z:-1
        onClicked: mesenge.enabled=false
    }

    GFile{
        id:file
        function save(){
            source=getDesktop()+"/547output"+ Qt.formatDateTime(new Date(), "yy-mm-dd-hh-mm-ss")+".txt"
            write(output.text)
            mesenge.show("已导出到"+source,5000)
        }
    }

    Rectangle{
        anchors.fill: parent
        border.color: "#80808080"
        border.width: 2
    }
    Item{
        x:2
        y:2
        Rectangle{
            width: window.width-4
            height: 30
            color:"#BBBBBB"
            Image{
                source:"qrc:/547rand.ico"
                width: 30
                height: 30
            }
            Text{
                x:32
                y:2
                text:window.title
                font.pixelSize: 20
            }
            DelButton{
                x:window.width-121
                width: 50
                height: 30
                y:3
                text: "设置"
                font.pixelSize: 20
                colorBg: "#00000000"
                colorBorder: "#00000000"
                padding: 0
                topPadding: 0
                onClicked: {
                    win_s.visible=true
                }
            }
            DelButton{
                x:window.width-66
                y:-3
                width: 30
                height: 30
                text: "-"
                font.pixelSize: 30
                colorBg: "#00000000"
                colorBorder: "#00000000"
                padding: 0
                topPadding: 8
                onClicked: {
                    window.visibility=Window.Minimized
                }
            }
            DelButton{
                x:window.width-36
                y:-3
                width: 30
                height: 30
                text: "×"
                colorBg: "#00000000"
                colorBorder: "#00000000"
                font.pixelSize: 30
                padding: 0
                type:6
                topPadding: 8
                onClicked: {
                    Qt.quit()
                }
            }
            Item{
                width: window.width-121
                height: 30
                MouseArea {
                    anchors.fill: parent
                    property int dragX
                    property int dragY
                    property bool dragging
                    onPressed: {
                        dragX = mouseX
                        dragY = mouseY
                        dragging = true
                    }
                    onReleased: {
                        dragging = false
                    }
                    onPositionChanged: {
                        if (dragging) {
                            window.x += mouseX - dragX
                            window.y += mouseY - dragY
                        }
                    }
                }
            }


        }

        Rectangle{
            x:10
            y:40
            width: 330
            height: 280
            color: "#E8E8E8"
            ScrollView {
                anchors.fill: parent
                TextArea {
                    property string tex:""
                    onTexChanged: {
                        text=tex
                    }
                    onTextChanged: {
                        text=tex
                    }
                    id:output
                    text: ""
                    horizontalAlignment: Text.Center
                    font.pixelSize: 30
                    color: "black"
                    background: Rectangle{
                        color: "#E8E8E8"
                        x:0
                        y:0
                        width: 280
                        height: 280
                    }
                    onFocusChanged: mesenge.enabled=false
                }
            }
        }
        Item{
            x:350
            y:48
            width: 280
            height: 80
            MouseArea{
                anchors.fill: parent
                z:-1
                onClicked: mesenge.enabled=false
            }
            DelButton{
                id:c1
                x:0
                y:0
                width: 100
                height: 30
                text: "抽一次"
                font.pixelSize: 20
                onClicked: {
                    sumn++
                    output.tex="["+sumn+"]"+cou()+"\n"+output.tex
                }
            }
            DelButton{
                id:cn
                x:120
                y:0
                width: 100
                height: 30
                text: "抽n次"
                font.pixelSize: 20
                onClicked: {
                    if(nummm>0)
                        for(var i=0;i<nummm;i++)
                        {
                            sumn++
                            output.tex="["+sumn+"]"+cou()+"\n"+output.tex
                        }
                }
            }
            CScrollBar{
                y:45
                text:"n="
                id:sb
                onValueChanged: nummm=value*50
                maxValue: 50
                Component.onCompleted: setValue(0.02)
                width: 120
                step: 0.02
            }
            DelButton{
                x:0
                y:80
                width: 100
                height:30
                text: "清除"
                font.pixelSize: 20
                onClicked: {
                    output.tex=""
                    sumn=0
                }
            }
            DelButton{
                x:120
                y:80
                width: 100
                height:30
                text: "导出"
                font.pixelSize: 20
                onClicked: file.save()
            }
            Rectangle{
                x:0
                y:130
                width: parent.width-60
                height: 130
                border.color: "#80808080"
                radius: 3
                MouseArea{
                    anchors.fill: parent
                    z:-1
                    onClicked: mesenge.enabled=false
                }
                DelButton{
                    id:qb
                    width: parent.width-20
                    height: 25
                    x:10
                    y:35
                    checkable: true
                    type: checked ? 3 : 1
                    text: "显示学号和名字"
                    checked: true
                    onCheckedChanged: {
                        if(checked)
                        {
                            xh.checked=false
                            mz.checked=false
                        }
                    }
                    onClicked: checked=true
                }
                DelButton{
                    id:xh
                    width: parent.width-20
                    height: 25
                    x:10
                    y:65
                    checkable: true
                    text: "只显示学号"
                    type: checked ? 3 : 1
                    onCheckedChanged: {
                        if(checked)
                        {
                            qb.checked=false
                            mz.checked=false
                        }
                    }
                    onClicked: checked=true
                }
                DelButton{
                    id:mz
                    width: parent.width-20
                    height: 25
                    x:10
                    y:95
                    checkable: true
                    type: checked ? 3 : 1
                    text: "只显示名字"
                    onCheckedChanged: {
                        if(checked)
                        {
                            xh.checked=false
                            qb.checked=false
                        }
                    }
                    onClicked: checked=true
                }
                DelButton{
                    text:"关于"
                    font.pixelSize: 16
                    width: 60
                    x:parent.width-width-10
                    y:8
                    height: 20
                    onClicked: about.visible=true
                    Window{
                        id:about
                        width: 300
                        height: 190
                        minimumHeight: height
                        maximumHeight: height
                        minimumWidth: width
                        maximumWidth: width
                        Image {
                            x:20
                            y:10
                            width: 70
                            height: 70
                            source: "qrc:/Qt.png"
                        }
                        Text{
                            x:90
                            y:25
                            font.pixelSize: 20
                            text:"Made with Qt6"
                        }
                        Text {
                            x:90
                            y:45
                            text: "(Desktop Qt 6.7.3 MinGW 64-bit)"
                        }
                        DelButton{
                            text:"源代码"
                            font.pixelSize: 16
                            width: 80
                            x:30
                            y:80
                            height: 20
                            onClicked: Qt.openUrlExternally("https://github.com/lazx547/547choice")
                        }
                        DelButton{
                            text:"547官网"
                            font.pixelSize: 16
                            width: 100
                            x:170
                            y:80
                            height: 20
                            onClicked: Qt.openUrlExternally("https://lazx547.github.io")
                        }
                        Rectangle{
                            border.color: "#80808080"
                            border.width: 1
                            radius: 4
                            x:20
                            y:110
                            width: parent.width-40
                            height: 60
                            Text{
                                text:"使用的开源组件:DelButton"
                                x:10
                                y:5
                                font.pixelSize: 16
                            }
                            DelButton{
                                x:80
                                y:30
                                text:"访问仓库"
                                width: 100
                                height: 20
                                onClicked: Qt.openUrlExternally("https://github.com/mengps/QmlControls/tree/master/DelButton")
                            }
                        }
                    }
                }
            }

        }

    }
}
