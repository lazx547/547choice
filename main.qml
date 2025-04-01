import QtQuick
import QtQuick.Controls
import QtQuick.Window
import GFile
import QtQuick.Dialogs
import QtQuick.Controls.Basic
import DelegateUI.Controls 1.0

Window {
    id: window
    minimumHeight: 300
    maximumHeight: 300
    minimumWidth: 580
    maximumWidth: 580
    visible:true
    width: 650
    height: 300
    color: "white"
    title: "547抽号器"
    property int sumn:0
    property int nummm: 1
    property int sim
    property var a:[]
    property int num_xh

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

    GFile{
        id:file
        function save(){
            source=getDesktop()+"/547output"+ Qt.formatDateTime(new Date(), "yy-mm-dd-hh-mm-ss")+".txt"
            write(output.text)
            mesenge.show("已导出到"+source,5000)
        }
    }

    MouseArea{
        anchors.fill: parent
        z:-1
        onClicked: mesenge.enabled=false
    }

    Component.onCompleted: {
        file.source="./source.txt"
        if(file.is("./source.txt"))
        {
            var s=file.read()
            num_xh=s.slice(0,s.indexOf(","))
            s=s.slice(s.indexOf(",")+1,s.length)
            var otherinfo=""
            if(num_xh==-1)
            {
                qb.checked=true
                qb.enabled=false
                xh.enabled=false
                mz.enabled=false
                otherinfo="，没有学号"
            }

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
            mesenge.show("成功读取文件，共"+sim+"人"+otherinfo,3000)
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
            a=a.slice(0,num_xh)
        else if(mz.checked)
            a=a.slice(num_xh,a.length)
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
        y:18
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
            Text {
                x:5
                y:8
                font.pixelSize:15
                text: "设置"
            }
            DelButton{
                id:qb
                width: parent.width-20
                height: 25
                x:10
                y:35
                checkable: true
                type: checked ? DelButtonType.Type_Primary : DelButtonType.Type_Default
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
                type: checked ? DelButtonType.Type_Primary : DelButtonType.Type_Default
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
                type: checked ? DelButtonType.Type_Primary : DelButtonType.Type_Default
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
