import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Window 2.3
import GFile 1.2

Window {
    id: window
    visible: true
    minimumHeight: 300
    maximumHeight: 300
    minimumWidth: 650
    maximumWidth: 650
    width: 650
    height: 300
    color: "white"
    title: "547抽号器"
    property int sumn:0
    property int nummm: 1
    property int sim
    property var a:[]

    GFile{
        id:file
    }

    Component.onCompleted: {
        file.source="./source.txt"
        if(file.is("./source.txt"))
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
            console.log(sim)
        }
        else
        {
            output.tex="未找到文件"
            c1.enabled=false
            cn.enabled=false
        }
    }

    function cou(){
        var a=coul()
        if(xh.checked)
            a=a.slice(0,5)
        else if(mz.checked)
            a=a.slice(5,a.length)
        return a
    }

    function coul(){
        var b=Math.floor(Math.random() * sim)+1
        return a[b-1]
    }

    Rectangle{
        x:10
        y:10
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
                background: Rectangle{
                    color: "#E8E8E8"
                    x:0
                    y:0
                    width: 280
                    height: 280
                }
            }
        }
    }
    Item{
        x:350
        y:30
        width: 280
        height: 80
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
            x:0
            y:40
            width: 100
            height: 30
            text: "抽n次"
            font.pixelSize: 20
            onClicked: {
                for(var i=0;i<nummm;i++)
                {
                    sumn++
                    output.tex="["+sumn+"]"+cou()+"\n"+output.tex
                }
            }
        }
        Rectangle{
            x:110
            y:-9
            border.color: "#000"
            width: 180
            height: 129
            Text{
                x:10
                y:10
                font.pixelSize: 20
                text:"n="
            }

            DelButton{
                rotation: 270
                x:140
                y:9
                width: 30
                height: 30
                text:"→"
                font.pixelSize: 20
                onClicked: {
                    sb.position+=0.0175
                }
            }
            DelButton{
                rotation: 90
                x:140
                y:89
                width: 30
                height: 30
                text:"→"
                font.pixelSize: 20
                onClicked: {
                    sb.position-=0.0175
                }
            }

            ScrollBar{
                id:sb
                onPositionChanged: {
                    if(position===0)
                        position=0.0175
                    else if(position===1)
                        position-=0.0175
                    nummm=position*57+1
                    if(nummm<10)
                        num.text="0"+nummm
                    else
                        num.text=nummm
                }
                position: 0.0175
                hoverEnabled: true
                active:hovered || pressed
                orientation:Qt.Horizontal
                width: 120
                stepSize: 0.0175
                snapMode: ScrollBar.SnapAlways
                x:10
                y:55
            }
            Rectangle{
                x:140
                y:49
                width: 30
                height: 30
                color: "#E8E8E8"
                Text{
                    id:num
                    text: "01"
                    horizontalAlignment: Text.Center
                    font.pixelSize: 25
                }
            }
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
        Rectangle{
            x:0
            y:131
            width: 160
            height: 120
            border.color: "#000"
            Text {
                x:5
                y:5
                font.pixelSize:15
                text: "设置"
            }
            Ccheckbox{
                id:qb
                width: 150
                height: 25
                x:9
                y:29
                text: "显示学号和名字"
                checked: true
                onCheckedChanged: {
                    if(checked)
                    {
                        xh.checked=false
                        mz.checked=false
                    }

                }
            }
            Ccheckbox{
                id:xh
                width: 150
                height: 25
                x:9
                y:59
                text: "只显示学号"
                onCheckedChanged: {
                    if(checked)
                    {
                        qb.checked=false
                        mz.checked=false
                    }
                }
            }
            Ccheckbox{
                id:mz
                width: 150
                height: 25
                x:9
                y:89
                text: "只显示名字"
                onCheckedChanged: {
                    if(checked)
                    {
                        xh.checked=false
                        qb.checked=false
                    }
                }
            }
        }
        DelButton{
            text:"关于"
            font.pixelSize: 16
            width: 60
            x:200
            y:200
            height: 20
            onClicked: about.visible=true
            Window{
                id:about
                width: 300
                height: 130
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
            }
        }
    }
}
