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
        if(!lockPosition)mouseAreaComponent.color="#787878"
        if(!debugStarted){
            debugStarted=true
            debug.color="#00000000"
            debug.border.width=0
            row.visible=false
        }
    }
    Rectangle {
        id: debug
        color: "#000000"
        anchors.fill: parent
        border.width: 1
        radius: 5
        Rectangle{
            id:mouseAreaComponent
            color: "#787878"
            anchors{
                bottom:parent.bottom
                right:parent.right
                rightMargin: (parent.width*0.5)-(width*0.5)
                bottomMargin: parent.height*0.01
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
                            newPosition=mapToItem(mainItem,mouse.x-debug.width+150,mouse.y-debug.height+15)
                            break
                        case 1:
                            newPosition=mapToItem(settingsItem,mouse.x-debug.width+150,mouse.y-debug.height+15)
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
                    lockPosition=!lockPosition
                    if(lockPosition)mouseAreaComponent.color="white"
                    if(!lockPosition)mouseAreaComponent.color="#787878"
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

                // release pos : color white or #787878
                onReleased: {
                    if(lockPosition)mouseAreaComponent.color="white"
                    if(!lockPosition)mouseAreaComponent.color="#787878"
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
                    text: debug_field_1.text
                    font.pixelSize: 12
                }

                Text {
                    id: text2
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                    color: "#e8e7e7"
                    text: debug_field_2.text
                    font.pixelSize: 12
                }

                Text {
                    id: text3
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    color: "#e8e7e7"
                    text: debug_field_3.text
                    font.pixelSize: 12
                }

                Text {
                    id: text4
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    color: "#e8e7e7"
                    text:debug_field_4.text
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
                    text:debug_field_5.text
                    font.pixelSize: 12
                }


                Text {
                    id: text6
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                    color: "#e8e7e7"
                    text: debug_field_6.text
                    font.pixelSize: 12
                }

                Text {
                    id: text7
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                    color: "#e8e7e7"
                    text:debug_field_7.text
                    font.pixelSize: 12
                }





                Text {
                    id: text8
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                    color: "#e8e7e7"
                    text:debug_field_8.text
                    font.pixelSize: 12
                }
            }
        }

    }

}
