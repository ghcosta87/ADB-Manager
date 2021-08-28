import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.LocalStorage 2.0

import QtQuick 2.0
import QtQuick.Controls 2.1

import QtQuick.Extras 1.4

import "adbCommands.js" as ADB
import "mainLogic.js" as JS
import "sqlDatabase.js" as SQL

Item {
    id: mainItem
    anchors.fill: parent

    Component.onCompleted: {
        SQL.startDatabase()
        SQL.setSavedData()
        SQL.loadDevices()
        timer.start()
        currentPage = 0
        gridSelectedItem=devicesGrid.currentIndex
        if (!mainPageFirstTime) {
            mainPageFirstTime = true
//            posY = appWindow.height -(appWindow.height * 0.6)
//            posX = appWindow.width-(appWindow.width * 0.5)
            click = !click
            console_title_text.text = "## - AGUARDANDO CONEXÃO - ##"
        }
    }

    Rectangle {
        visible: false
        Timer {
            id: timer
            interval: 50
            repeat: true
            onTriggered: {
                if (JS.textToBool(loading_timer_control.text)) {
                    interval.start()
                    timer.stop()
                } else {
                    timer.start()
                }
                if(JS.textToBool(grid_updater_timer.text)){
                    devicesGrid.model.remove(devicesGrid.currentIndex, 1)
                    if (devicesGrid.count == 0)
                        devicesGrid.currentIndex = -1
                    SQL.loadDevices()
                    grid_updater_timer.text="false"
                }
            }
        }


        Timer {
            id: interval
            interval: 1500
            onTriggered: {
                ADB.load_content()
                loading_timer_control.text = "false"
                timer.start()
                interval.stop()
                //loading_gif.visible = true
            }
        }
        Timer {
            id: pause_timers
            interval: 5000
            repeat: true
            onTriggered: {
                interval.stop()
                timer.stop()
            }
        }
        Timer {
            id: pause_timers_interval
            interval: 5000
            repeat: true
            onTriggered: {
                pause_timers.stop()
                timer.start()
            }
        }
    }

    Rectangle {
        id: mainComponent
        color: myBackground
        anchors.fill: parent

        GridView {
            id: devicesGrid
            //            clip: true
            cellWidth: cellWidthProp
            cellHeight: cellHeightProp
            highlightFollowsCurrentItem: false
            focus: true
            model: ListModel {}
            height: parent.height *0.45
            anchors {
                top: parent.top
                topMargin: marginHeight+globalMenu.height
                left: parent.left
                leftMargin: marginWidth
                right: parent.right
                rightMargin: marginWidth
            }
            highlight: Rectangle {
                height: cellHeightProp
                color: "black"
                width: cellWidthProp
                anchors {
                    top: devicesGrid.currentItem.top
                    topMargin: 0
                }
                radius: 4
                x: devicesGrid.currentItem.x
                y: devicesGrid.currentItem.y
            }
            delegate: Item {
                //Column{
                Rectangle {
                    id: celula
                    height: cellHeightProp - (2 * celula_marca_height)
                    opacity: 0.89
                    width: cellWidthProp - (2 * celula_marca_width)
                    radius: 6
                    color: consoleBorderColor
                    anchors {
                        top: parent.top
                        topMargin: celula_marca_height
                        left: parent.left
                        leftMargin: celula_marca_width
                    }

                    Rectangle{
                        id:grid_title
                        height: cellHeightProp *0.18
                        color: noColor
                        anchors {
                            top: parent.top
                            topMargin: celula_marca_height
                            right: parent.right
                            rightMargin: celula_marca_width
                            left: parent.left
                            leftMargin: celula_marca_width
                        }
                        Text {
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.WrapAnywhere
                            font.italic: false
                            font.bold: true
                            fontSizeMode: Text.VerticalFit
                            minimumPixelSize: 1
                            text: grid_indice + "." + grid_nome
                        }
                    }

                    Rectangle{
                        id: grid_ico_container
                        color:consoleTitleColor
                        width:  grid_ico_container.height
                        radius: 6
                        anchors {
                            top: grid_title.bottom
                            topMargin: celula_marca_height
                            bottom: parent.bottom
                            bottomMargin: celula_marca_height
                            right:parent.right
                            rightMargin: celula_marca_width
                        }
                    }

                    Image {
                        id: grid_ico
                        width :grid_ico_container.width-(marginWidth*0.5)
                        height:grid_ico_container.height-(marginHeight*0.5)
                        source: grid_image_path
                        fillMode: Image.Stretch
                        anchors {
                            top: grid_title.bottom
                            topMargin: celula_marca_height*2
                            bottom: parent.bottom
                            bottomMargin: celula_marca_height*2
                            right:parent.right
                            rightMargin: celula_marca_width*2
                        }
                    }

                    Text {
                        anchors {
                            top: grid_title.bottom
                            bottom: parent.bottom
                            right: grid_ico_container.left
                            rightMargin: celula_marca_width
                            left: parent.left
                            leftMargin: celula_marca_width
                        }

                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        textFormat: Text.RichText
                        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                        fontSizeMode: Text.Fit
                        minimumPixelSize: 1
                        text: "<p><i>" + grid_ip + "</p></i>"
                              + "<p><i>" + grid_desc + "</p></i>"
                    }

                    MouseArea {
                        id: itemMouseArea
                        anchors.fill: parent
                        onClicked: {
                            devicesGrid.currentIndex = index
                            gridSelectedItem=index                   
                        }
                    }
                }
            }
        }

        Rectangle {
            id: mainConsole
            color: consoleColor
            border.width: 2
            border.color: consoleBorderColor
            anchors {
                top: devicesGrid.bottom
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                topMargin: marginHeight
                bottomMargin: marginHeight
                leftMargin: marginWidth
                rightMargin: marginWidth
            }

            Rectangle {
                id: loadingArea
                color: noColor
                width: 70
                anchors {
                    top: parent.top
                    bottom: containerLogTerminal.top
                    right: parent.right
                    topMargin: titleBar.height + marginHeight
                    rightMargin: marginWidth
                }

                Rectangle {
                    id: loading_gif_rec
                    width: loading_gif_rec.height
                    color: '#00000000'
                    anchors {
                        top: parent.top
                        bottom: loading_text_rec.top
                        right: parent.right
                        left: parent.left
                        bottomMargin: marginHeight - 5
                    }
                    AnimatedImage {
                        id: loading_gif
                        visible: JS.textToBool(loading_gif_visibility.text)
                        source: "imagens/loadingBuffering.gif"
                        anchors.fill: parent
                    }
                }

                Rectangle {
                    id: loading_text_rec
                    color: '#00000000'
                    height: parent.height * 0.2
                    anchors {
                        bottom: loadingArea.bottom
                        right: parent.right
                        left: parent.left
                    }
                    Text {
                        id: loading_text
                        color: "white"
                        visible: JS.textToBool(loading_text_visibility.text)
                        text: loading_text_context.text
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        fontSizeMode: Text.Fit
                        minimumPixelSize: 1
                    }
                }
            }

            Rectangle {
                id: titleBar
                color: "#4d4a4a"
                height: parent.height * (20 / 100)
                anchors {
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
                Text {
                    id: console_title
                    anchors.fill: parent
                    text: console_title_text.text
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "white"
                    //fontSizeMode: Text.Fill
                    minimumPixelSize: 1
                }
            }

            Text {
                id: console_area
                lineHeight: 0.9
                //fontSizeMode: Text.Fill
                color: "white"
                text: console_area_text.text
                minimumPixelSize: 1
                horizontalAlignment: Text.AlignJustify
                verticalAlignment: Text.AlignTop
                anchors {
                    top: titleBar.bottom
                    bottom: parent.bottom
                    left: parent.left
                    leftMargin: marginWidth
                    right: parent.right
                }
            }


            Rectangle{
                id:containerLogTerminal
                height: parent.height*0.45
                color: noColor
                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    right: parent.right
                    topMargin: marginHeight
                }
                LogTerminal{
                }
            }
        }

    }
}
