import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.LocalStorage 2.0

import QtQuick 2.0
import QtQuick.Controls 2.1

import QtQuick.Extras 1.4

import 'adbCommands.js' as ADB
import 'mainLogic.js' as JS
import 'sqlDatabase.js' as SQL

Item {
    id:mainItem
    anchors.fill: parent

    Component.onCompleted: {
        SQL.startDatabase()
        SQL.setSavedData()
        ADB.a04_carregar_dispositivos()
        ADB.ler_arquivos()
        SQL.loadDevices()

        //janela_cadastro.visible=false
        timer.start()

        currentPage=0
    }

    Rectangle{
        visible: false
        Timer{
            id:timer
            interval:2000
            repeat: true
            onTriggered: {
                runScript.console_fill()
                ADB.ler_arquivos()
                loading_gif.visible=false
                interval.start()
                timer.stop()
            }
        }
        Timer{
            id:interval
            interval: 2000
            onTriggered: {
                timer.start()
                loading_gif.visible=true
            }
        }
        Timer{
            id:pause_timers
            interval:5000
            repeat: true
            onTriggered: {
                interval.stop()
                timer.stop()
            }
        }
        Timer{
            id:pause_timers_interval
            interval:5000
            repeat: true
            onTriggered: {
                pause_timers.stop()
                timer.start()
            }
        }
    }

    Rectangle{
        id:mainComponent
        color: myBackground
        anchors.fill: parent

        Rectangle{
            id:botao_canectar
            radius: 5
            border.width: 2
            color: "grey"
            Text {
                text: connectDevice
                anchors.fill:parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
                minimumPixelSize: 1
                wrapMode: Text.WrapAnywhere
            }
            width: buttonWidth
            height: buttonHeight
            anchors{
                top: parent.top
                left: parent.left
                topMargin: maginHeight
                leftMargin: marginWidth
            }
            MouseArea{
                anchors.fill: parent
                onPressed: parent.color=buttonPressed
                onReleased:{
                    parent.color=buttonRealeased
                    ADB.a07_conectar_dispositivos(devicesGrid.currentIndex)
                }
            }
        }

        Rectangle{
            id:botao_remover
            radius: 5
            border.width: 2
            color: "grey"
            Text {
                text: removeDevice
                anchors.fill:parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
                minimumPixelSize: 1
                wrapMode: Text.WrapAnywhere
            }
            width: buttonWidth
            height: buttonHeight
            anchors{
                top: parent.top
                right: parent.right
                topMargin: maginHeight
                rightMargin: marginWidth
            }
            MouseArea{
                anchors.fill: parent
                onPressed: parent.color=buttonPressed
                onReleased:{
                    parent.color=buttonRealeased
                    runScript.desconectar_dispositivos()
                }
            }
        }

        GridView{
            id:devicesGrid
            clip:true
            cellWidth: cellWidth
            cellHeight: cellHeight
            highlightFollowsCurrentItem: false
            focus: true
            model:ListModel{}
            height:parent.height/2
            anchors{
                top: botao_canectar.bottom
                topMargin: maginHeight
                // bottom: botao_hab_wifi.top
                //bottomMargin: height_margin
                left: parent.left
                leftMargin: marginWidth
                right: parent.right
                rightMargin: marginWidth
            }
            highlight: Rectangle {
                height: cellHeight
                color:"black"
                width: cellWidth
                anchors{
                    top:devicesGrid.currentItem.top
                    topMargin: 0
                }
                radius: 7
                border.width: 2
                x: devicesGrid.currentItem.x
                y: devicesGrid.currentItem.y
            }
            delegate: Item{
                //Column{
                Rectangle{
                    id:celula
                    height: cellHeight-(2*celula_marca_height)
                    opacity: 0.89
                    width: cellWidth-(2*celula_marca_width)
                    radius: 6
                    anchors{
                        top: parent.top
                        topMargin: celula_marca_height
                        left: parent.left
                        leftMargin: celula_marca_width
                    }
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "#96fbc4"
                        }

                        GradientStop {
                            position: 1
                            color: "#f9f586"
                        }
                    }
                    Image{
                        id:grid_ico
                        width: cellWidth/3
                        height: cellHeight/3
                        anchors{
                            top: parent.top
                            topMargin: celula_marca_height
                            left: parent.left
                            leftMargin: celula_marca_width
                        }
                        source:"file:///"+grid_image_path
                        fillMode: Image.Stretch
                    }
                    Text{
                        anchors{
                            top: parent.top
                            topMargin: celula_marca_height
                            right: parent.right
                            rightMargin: celula_marca_width
                            left: grid_ico.right
                            leftMargin: celula_marca_width
                        }
                        height: cellHeight/2
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        //textFormat: Text.RichText
                        wrapMode: Text.WrapAnywhere
                        fontSizeMode: Text.HorizontalFit
                        minimumPixelSize: 1
                        font.pixelSize: 50
                        text:grid_indice+"."+grid_nome
                    }
                    Text{
                        anchors{
                            top: grid_ico.bottom
                            topMargin: celula_marca_height
                            right: parent.right
                            rightMargin: celula_marca_width
                            left: parent.left
                            leftMargin: celula_marca_width
                        }
                        height: cellHeight/2
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        //textFormat: Text.RichText
                        wrapMode: Text.WrapAnywhere
                        fontSizeMode: Text.Fit
                        minimumPixelSize: 1
                        font.pixelSize: 50
                        //lineHeight: 0.9
                        //font.pixelSize: parent.height*0.06
                        text:"<p><i>IP: " + grid_ip+"</p></i>"
                             +"<p><i>Descricao: " + grid_desc+"</p></i>"
                             +"<p><i>Imagem: " + grid_image_path+"</p></i>"
                    }
                    MouseArea{
                        id: itemMouseArea
                        anchors.fill: parent
                        onClicked: {
                            devicesGrid.currentIndex=index
                        }
                    }
                }
            }
        }

        Rectangle{
            id:consoleSubComponent
            color: "#00000000"
            border.width: 1
            radius: 6
            anchors{
                top: devicesGrid.bottom
                topMargin: maginHeight
                bottom:botao_hab_wifi.top
                bottomMargin: maginHeight
                left: parent.left
                leftMargin: marginWidth
                right:parent.right
                rightMargin: marginWidth
            }
            Text {
                id: console_title
                horizontalAlignment: Text.AlignHCenter
                height: parent.height*(15/100)
                //fontSizeMode: Text.Fill
                minimumPixelSize: 1
                font.pixelSize: 20
                anchors{
                    top: parent.top
                    left: parent.left
                    right: parent.right
                }
            }
            Text{
                id:console_area
                lineHeight: 1.5
                anchors{
                    top:console_title.bottom
                    bottom: parent.bottom
                    left: parent.left
                    leftMargin: marginWidth
                    right: parent.right
                }
            }
        }

        Rectangle{
            id:botao_hab_wifi
            radius: 5
            border.width: 2
            color: "grey"
            Text {
                text: setWifi
                anchors.fill:parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
                minimumPixelSize: 1
                wrapMode: Text.WrapAnywhere
            }
            width: buttonWidth
            height: buttonHeight
            anchors{
                bottom: parent.bottom
                left: parent.left
                bottomMargin: maginHeight
                leftMargin: marginWidth
            }
            MouseArea{
                anchors.fill: parent
                onPressed: parent.color=buttonPressed
                onReleased:{
                    parent.color=buttonRealeased
                    runScript.run()
                }
            }
        }

        Rectangle{
            id:botao_cadastrar
            radius: 5
            border.width: 2
            color: "grey"
            Text {
                text: toSettingsPage
                anchors.fill:parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
                minimumPixelSize: 1
                wrapMode: Text.WrapAnywhere
            }
            width: buttonWidth
            height: buttonHeight
            anchors{
                bottom: parent.bottom
                right: parent.right
                bottomMargin: maginHeight
                rightMargin: marginWidth
            }
            MouseArea{
                anchors.fill: parent
                onPressed: parent.color=buttonPressed
                onReleased:{ parent.color=buttonRealeased; stackView.push(settingsPage)}
                //                                onPressed: parent.color=botao_pressionado
                //                                onReleased:{ parent.color=botao_solto; janela_cadastro.visible=true}
            }
        }

        StackView{
            id:stackDebug
            x:posX
            y:posY
            onXChanged:posX=stackDebug.x
            onYChanged:posY=stackDebug.y
            width: debugWindowWidth
            height: debugWindowHeight
            clip: false
            rotation: 0
            initialItem: debugFloatingWindow
        }
        Component{
            id:debugFloatingWindow
            Debug{}
        }

    }

    AnimatedImage{
        id: loading_gif
        source: "imagens/loading-buffering.gif"
        anchors.fill: parent
        anchors{
            topMargin: parent.height*(13/100)
            bottomMargin: parent.height*(77/100)
            leftMargin: parent.width*(85/100)
            rightMargin: parent.width*(5/100)
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.75;height:480;width:640}D{i:48;invisible:true}
}
##^##*/
