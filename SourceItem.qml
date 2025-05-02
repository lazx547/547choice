import QtQuick

Rectangle{
    border.color: "#CCCCCC"
    border.width: 1
    property string name:""
    property var per
    property int num
    property int n
    width: 300
    height: 40
    Text{
        text:name
        x:2
        y:2
        font.pixelSize: 20
    }
    Text{
        text:"人数"+num
        x:2
        y:22
        font.pixelSize: 15
    }
    DelButton{
        text: "选择"
        x:200
        width: 60
        height: 30
        y:5
        onClicked: per.cclass=n;
    }
}
