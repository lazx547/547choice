import QtQuick 2.12
import QtQuick.Controls 2.3
import QtQuick.Window 2.3

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
    function cou(is_lzy){
        var a=coul(is_lzy)
        if(xh.checked)
            a=a.slice(0,5)
        else if(mz.checked)
            a=a.slice(5,a.length)
        return a
    }

    function coul(is_lzy){
        if(!is_lzy)
            var a=Math.floor(Math.random() * 58);
        else
            var a=Math.floor(Math.random() * 59);
        switch(a)
        {
        case 1:
            return "54701[name]"
        case 2:
            return "54702[name]"
        case 3:
            return "54703[name]"
        case 4:
            return "54704[name]"
        case 5:
            return "54705[name]"
        case 6:
            return "54706[name]"
        case 7:
            return "54707[name]"
        case 8:
            return "54708[name]"
        case 9:
            return "54709[name]"
        case 10:
            return "54710[name]"
        case 11:
            return "54711[name]"
        case 12:
            return "54712[name]"
        case 13:
            return "54713[name]"
        case 14:
            return "54714[name]"
        case 15:
            return "54715[name]"
        case 16:
            return "54716[name]"
        case 17:
            return "54717[name]"
        case 18:
            return "54718[name]"
        case 19:
            return "54719[name]"
        case 20:
            return "54720[name]"
        case 21:
            return "54721[name]"
        case 22:
            return "54722[name]"
        case 23:
            return "54723[name]"
        case 24:
            return "54724[name]"
        case 25:
            return "54725[name]"
        case 26:
            return "54726[name]"
        case 27:
            return "54727[name]"
        case 28:
            return "54728[name]"
        case 29:
            return "54729[name]"
        case 30:
            return "54730[name]"
        case 31:
            return "54731[name]"
        case 32:
            return "54732[name]"
        case 33:
            return "54733[name]"
        case 34:
            return "54734[name]"
        case 35:
            return "54735[name]"
        case 36:
            return "54736[name]"
        case 37:
            return "54737[name]"
        case 38:
            return "54738[name]"
        case 39:
            return "54739[name]"
        case 40:
            return "54740[name]"
        case 41:
            return "54741[name]"
        case 42:
            return "54742[name]"
        case 43:
            return "54743[name]"
        case 44:
            return "54744[name]"
        case 45:
            return "54745[name]"
        case 46:
            return "54746[name]"
        case 47:
            return "54747[name]"
        case 48:
            return "54748[name]"
        case 49:
            return "54749[name]"
        case 50:
            return "54750[name]"
        case 51:
            return "54751[name]"
        case 52:
            return "54752[name]"
        case 53:
            return "54753[name]"
        case 54:
            return "54754[name]"
        case 55:
            return "54755[name]"
        case 56:
            return "54756[name]"
        case 57:
            return "54757[name]"
        case 58:
            return "54758[name]"
        default:
            return cou(lzy.checkState==Qt.Checked)
        }
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
        Button{
            x:0
            y:0
            width: 100
            height: 30
            text: "抽一次"
            font.pixelSize: 20
            onClicked: {
                sumn++
                output.tex="["+sumn+"]"+cou(lzy.checkState==Qt.Checked)+"\n"+output.tex
            }
        }
        Button{
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
                    output.tex="["+sumn+"]"+cou(lzy.checkState==Qt.Checked)+"\n"+output.tex
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

            Button{
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
            Button{
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
        Button{
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
            width: 140
            height: 112
            border.color: "#000"
            Text {
                x:5
                y:5
                font.pixelSize:15
                text: "设置"
            }
            CheckBox{
                id:lzy
                x:9
                y:29
                text: "包括[转班名字]"
            }
            RadioButton{
                id:qb
                x:9
                y:49
                text: "显示学号和名字"
                checked: true
            }
            RadioButton{
                id:xh
                x:9
                y:69
                text: "只显示学号"
            }
            RadioButton{
                id:mz
                x:9
                y:89
                text: "只显示名字"
            }
        }
        Rectangle{
            x:150
            y:131
            width: 140
            height: 112
            border.color: "#000"
            Text {
                x:5
                y:5
                font.pixelSize:15
                text: "关于"
            }
            Button{
                x:35
                y:30
                width: 70
                height: 20
                text: "关于Qt"
                font.pixelSize: 15
                onClicked: {
                    qtinfo.visible=true
                }
                Window {
                    id:qtinfo
                    visible: false
                    minimumHeight: 470
                    maximumHeight: 470
                    minimumWidth: 500
                    maximumWidth: 500
                    title: "About Qt"
                    width: 500
                    height: 470
                    Image{
                        x:10
                        y:10
                        width: 80
                        height: 80
                        source: "qrc:/Qt.png"
                    }
                    Item{
                        x:100
                        y:10
                        width: 380
                        height: 480
                        Text{
                            wrapMode: Text.WordWrap
                            anchors.fill: parent
                            text:"This program uses Qt version 6.7.3.\n\nQt is a C++ to olkit for cross-platform application development.\n\nQt provides single-source portability across all major desktop operating syste ms.It is also available for embedded Linux and other embedded and mobile operating systems.\n\nQt is available under multiple licensing options designed to accommodate the needs of our various users.\n\nQt licensed under our commercial license agreement is appropriate for development of proprietary/commercial software where you do not want to share any source code with third parties or otherwise cannot comply with the tems of GNU (L)GPL.\n\nQt licensed under GNU (L)GPL is appropriate for the development ofQt applications provided you can comply with the terms and conditions of therespective licenses.\n\nPlease see qt.io/licensing for an overview of Qt licensing.\n\nCopyright (C) 2024 The Qt Company Ltd and other contributors.\n\nQt and the Qt logo are trademarks of The Qt Company Ltd.\n\nQt is The Qt Company Ltd product developed as an open source project. See qt.io for more information."
                        }
                    }
                }
            }
            Button{
                x:35
                y:60
                width: 70
                height: 20
                text: "源代码"
                font.pixelSize: 15
                onClicked: {
                    Qt.openUrlExternally("https://github.com/lazx547/547choice")
                }
            }
        }
    }
}
