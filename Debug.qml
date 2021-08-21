import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.LocalStorage 2.0

import QtQuick 2.0
import QtQuick.Controls 2.1

import QtQuick.Extras 1.4

import 'mainLogic.js' as JS

Item {

    Component.onCompleted: {
        if(click){
            debug.color="#00000000"
            debug.border.width=0
            row.visible=false
        }else{
            debug.color="#000000"
            debug.border.width=1
            row.visible=true
        }
        if(lockPosition)mouseAreaComponent.color="white"
        if(!lockPosition)mouseAreaComponent.color="red"
    }
    Rectangle {
        id: debug
        color: "#000000"
        anchors.fill: parent
        border.width: 1
        radius: 5
        Rectangle{
            id:mouseAreaComponent
            color: "red"
            anchors{
                bottom:parent.bottom
                right:parent.right
                bottomMargin: 5
                rightMargin: 20
            }

            radius: 100
            width: 25
            height: 25
            MouseArea{
                id:mousearea
                anchors.fill: parent
                x: 76
                y: 119

                //  position change : no color changes
                onPositionChanged:{
                    var newPosition
                    if(!lockPosition){
                        switch(currentPage){
                        case 0:
                            newPosition=mapToItem(mainItem,mouse.x-debug.width+25,mouse.y-debug.height+15)
                            break
                        case 1:
                            newPosition=mapToItem(settingsItem,mouse.x-debug.width+25,mouse.y-debug.height+15)
                            break
                        }
                        stackDebug.x=newPosition.x
                        stackDebug.y=newPosition.y
                    }else{
                        posX=stackDebug.x
                        posY=stackDebug.y
                    }
                }

                //   position locker : color white
                onClicked: {
                    text1.text=field1+posX
                    text2.text=field2+posY
                    text3.text=field3
                    text4.text=field4
                    text5.text=field5
                    text6.text=field6
                    text7.text=field7
                    text8.text=field8
                    lockPosition=!lockPosition
                    if(lockPosition)mouseAreaComponent.color="white"
                    if(!lockPosition)mouseAreaComponent.color="red"
                }

                // position movement : color yellow
                onPressAndHold: {
                    switch(currentPage){
                    case 0:
                        text2.text=field2+" on main"
                        break
                    case 1:text3.text=field2+" on setting"
                        break
                    }
                    mouseAreaComponent.color="yellow"
                }

                // release pos : color white or red
                onReleased: {
                    if(lockPosition)mouseAreaComponent.color="white"
                    if(!lockPosition)mouseAreaComponent.color="red"
                }

                // hide button : no color change
                onDoubleClicked: {
                    click=!click
                    if(click){
                        debug.color="#00000000"
                        debug.border.width=0
                        row.visible=false
                    }else{
                        debug.color="#000000"
                        debug.border.width=1
                        row.visible=true
                    }
                }
            }
        }

        Row {
            id: row
            anchors.fill:parent
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            anchors.rightMargin: 0


            Column {
                id: column
                width: parent.width/2
                height: parent.height

                Text {
                    id: text1
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    color: "#e8e7e7"
                    text: qsTr("Text")
                    font.pixelSize: 12
                }

                Text {
                    id: text2
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                    color: "#e8e7e7"
                    text: qsTr("Text")
                    font.pixelSize: 12
                }

                Text {
                    id: text3
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    color: "#e8e7e7"
                    text: qsTr("Text")
                    font.pixelSize: 12
                }

                Text {
                    id: text4
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    color: "#e8e7e7"
                    text: qsTr("Text")
                    font.pixelSize: 12
                }


            }
            Column {
                id: column1
                width: parent.width/2
                height: parent.height

                Text {
                    id: text5
                    width: parent.width
                    color: "#e8e7e7"
                    horizontalAlignment: Text.AlignHCenter
                    text: qsTr("Text")
                    font.pixelSize: 12
                }


                Text {
                    id: text6
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    color: "#e8e7e7"
                    text: qsTr("Text")
                    font.pixelSize: 12
                }

                Text {
                    id: text7
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                    color: "#e8e7e7"
                    text: qsTr("Text")
                    font.pixelSize: 12
                }





                Text {
                    id: text8
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                    color: "#e8e7e7"
                    text: qsTr("Text")
                    font.pixelSize: 12
                }
            }
        }

    }

}
