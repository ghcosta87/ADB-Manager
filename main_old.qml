import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.LocalStorage 2.0


import QtQuick 2.0
import QtQuick.Controls 2.1
import QtQuick.Controls 1.4 as Calendar_item

import Qt.labs.calendar 1.0
import QtQuick.Extras 1.4

import 'adbCommands.js' as adb

Window {
    id:janela_principal
    width: janela_width
    height:janela_height
    x:Calljava.a02_selecionar_constante("window_x")
    y:Calljava.a02_selecionar_constante("window_y")
    visible: true

    property string dbId: 'MyData'
    property string dbVersion: '2.0'
    property string dbDescription: 'Database application'
    property int dbsize: 1000000
    property var db

    property int janela_width:Calljava.a02_selecionar_constante("window_width")
    property int janela_height:Calljava.a02_selecionar_constante("window_height")

    property int botao_width:janela_principal.width*(45/100)
    property int botao_height:janela_principal.height*(10/100)

    property int width_margin:janela_principal.width*(2/100)
    property int height_margin:janela_principal.height*(2/100)

    property int celula_width:janela_principal.width*(50/100)
    property int celula_height:janela_principal.height*(25/100)
    property int celula_marca_width:janela_principal.width*(1/100)
    property int celula_marca_height:janela_principal.height*(1/100)

    property int input_text_height:janela_principal.height*(10/100)

    property string botao_pressionado: "white"
    property string botao_solto: "grey"

    property string conectar: "Conectar"
    property string remover: "Remover"
    property string wifi: "Configurar wifi"
    property string cadastrar: "Cadastrar novo dispositivo"
    property string voltar: "Voltar"

    property Gradient background:Gradient {
        GradientStop {
            position: 0
            color: "#84fab0"
        }

        GradientStop {
            position: 1
            color: "#8fd3f4"
        }
    }

    Component.onCompleted: {
        Calljava.grabPath()

//        runScript.console_fill()
        Calljava.a01_funcao_inicial()
        Calljava.a03_setar_constantes()
        Calljava.a04_carregar_dispositivos()
        Calljava.ler_arquivos()

        janela_cadastro.visible=false

        temporizador.start()    
    }

    Component.onDestruction: {
        Calljava.a03_setar_constantes()
    }

    Timer{
        id:temporizador
        interval:2000
        repeat: true
        onTriggered: {
            runScript.console_fill()
            Calljava.ler_arquivos()
            loading_gif.visible=false
            intervalo.start()
            temporizador.stop()
        }
    }
    Timer{
        id:intervalo
        interval: 2000
        onTriggered: {
            temporizador.start()
            loading_gif.visible=true
        }
    }
    Timer{
        id:pause_timers
        interval:5000
        repeat: true
        onTriggered: {
            intervalo.stop()
            temporizador.stop()
        }
    }
    Timer{
        id:pause_timers_interval
        interval:5000
        repeat: true
        onTriggered: {
            pause_timers.stop()
            temporizador.start()
        }
    }

    Rectangle{
        id:janela_principal_rec
        color: "#84fab0"
        anchors.fill: parent
        gradient: background
        Rectangle{
            id:botao_canectar
            radius: 5
            border.width: 2
            color: "grey"
            Text {
                text: conectar
                anchors.fill:parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
                minimumPixelSize: 1
                wrapMode: Text.WrapAnywhere
            }
            width: botao_width
            height: botao_height
            anchors{
                top: parent.top
                left: parent.left
                topMargin: height_margin
                leftMargin: width_margin
            }
            MouseArea{
                anchors.fill: parent
                onPressed: parent.color=botao_pressionado
                onReleased:{
                    parent.color=botao_solto
                    Calljava.a07_conectar_dispositivos(dispositivos.currentIndex)
                }
            }
        }
        Rectangle{
            id:botao_remover
            radius: 5
            border.width: 2
            color: "grey"
            Text {
                text: remover
                anchors.fill:parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
                minimumPixelSize: 1
                wrapMode: Text.WrapAnywhere
            }
            width: botao_width
            height: botao_height
            anchors{
                top: parent.top
                right: parent.right
                topMargin: height_margin
                rightMargin: width_margin
            }
            MouseArea{
                anchors.fill: parent
                onPressed: parent.color=botao_pressionado
                onReleased:{
                    parent.color=botao_solto
                    runScript.desconectar_dispositivos()
                }
            }
        }
        GridView{
            id:dispositivos
            clip:true
            cellWidth: celula_width
            cellHeight: celula_height
            highlightFollowsCurrentItem: false
            focus: true
            model:ListModel{}
            height:parent.height/2
            anchors{
                top: botao_canectar.bottom
                topMargin: height_margin
                // bottom: botao_hab_wifi.top
                //bottomMargin: height_margin
                left: parent.left
                leftMargin: width_margin
                right: parent.right
                rightMargin: width_margin
            }
            highlight: Rectangle {
                height: celula_height
                color:"black"
                width: celula_width
                anchors{
                    top:dispositivos.currentItem.top
                    topMargin: 0
                }
                radius: 7
                border.width: 2
                x: dispositivos.currentItem.x
                y: dispositivos.currentItem.y
            }
            delegate: Item{
                //Column{
                Rectangle{
                    id:celula
                    height: celula_height-(2*celula_marca_height)
                    opacity: 0.89
                    width: celula_width-(2*celula_marca_width)
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
                        width: celula_width/3
                        height: celula_height/3
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
                        height: celula_height/2
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
                        height: celula_height/2
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
                            dispositivos.currentIndex=index
                        }
                    }
                }
            }
        }
        Rectangle{
            color: "#00000000"
            border.width: 1
            radius: 6
            anchors{
                top: dispositivos.bottom
                topMargin: height_margin
                bottom:botao_hab_wifi.top
                bottomMargin: height_margin
                left: parent.left
                leftMargin: width_margin
                right:parent.right
                rightMargin: width_margin
            }
            Text {
                id: console_title
                horizontalAlignment: Text.AlignHCenter
                height: parent.height*(15/100)
                fontSizeMode: Text.Fill
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
                    leftMargin: width_margin
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
                text: wifi
                anchors.fill:parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
                minimumPixelSize: 1
                wrapMode: Text.WrapAnywhere
            }
            width: botao_width
            height: botao_height
            anchors{
                bottom: parent.bottom
                left: parent.left
                bottomMargin: height_margin
                leftMargin: width_margin
            }
            MouseArea{
                anchors.fill: parent
                onPressed: parent.color=botao_pressionado
                onReleased:{
                    parent.color=botao_solto
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
                text: cadastrar
                anchors.fill:parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
                minimumPixelSize: 1
                wrapMode: Text.WrapAnywhere
            }
            width: botao_width
            height: botao_height
            anchors{
                bottom: parent.bottom
                right: parent.right
                bottomMargin: height_margin
                rightMargin: width_margin
            }
            MouseArea{
                anchors.fill: parent
                onPressed: parent.color=botao_pressionado
                onReleased:{ parent.color=botao_solto; janela_cadastro.visible=true}
            }
        }
    }

    Rectangle {
        id: janela_cadastro
        gradient: background
        anchors.fill: parent
        TextField{
            id:nome
            text:"Disite o nome do dispositivo"
            height: input_text_height
            anchors{
                top: parent.top
                topMargin: height_margin
                left: parent.left
                leftMargin: width_margin
                right: parent.right
                rightMargin: width_margin
            }
            onPressed:clear()
        }
        TextField{
            id:ip
            text:"Digite o IP do dispositivo"
            height: input_text_height
            anchors{
                top:nome.bottom
                topMargin: height_margin
                left: parent.left
                leftMargin: width_margin
                right: parent.right
                rightMargin: width_margin
            }
            onPressed:clear()
        }
        TextField{
            id:image_path
            text:"Digite o caminho completo para o icone"
            height: input_text_height
            anchors{
                top: ip.bottom
                topMargin: height_margin
                left: parent.left
                leftMargin: width_margin
                right: parent.right
                rightMargin: width_margin
            }
            onPressed:clear()
        }
        TextField{
            id:descricao
            text:"Adicione a descricao"
            height: input_text_height
            anchors{
                top: image_path.bottom
                topMargin: height_margin
                left: parent.left
                leftMargin: width_margin
                right: parent.right
                rightMargin: width_margin
            }
            onPressed:clear()
        }

        Rectangle{
            id:cadastro_cadastrar
            radius: 5
            border.width: 2
            color: "grey"
            Text {
                text: cadastrar
                anchors.fill:parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
                minimumPixelSize: 1
                wrapMode: Text.WrapAnywhere
            }
            width: botao_width
            height: botao_height
            anchors{
                bottom: parent.bottom
                left: parent.left
                bottomMargin: height_margin
                leftMargin: width_margin
            }
            MouseArea{
                anchors.fill: parent
                onPressed: parent.color=botao_pressionado
                onReleased:{
                    parent.color=botao_solto
                    runScript.console_fill()
                    Calljava.a05_cadastrar_dispositivo()
                    janela_cadastro.visible=false
                    Calljava.a04_carregar_dispositivos()
                    Calljava.ler_arquivos()
                }
            }
        }
        Rectangle{
            id:cadastro_voltar
            radius: 5
            border.width: 2
            color: "grey"
            Text {
                text: voltar
                anchors.fill:parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
                minimumPixelSize: 1
                wrapMode: Text.WrapAnywhere
            }
            width: botao_width
            height: botao_height
            anchors{
                bottom: parent.bottom
                right: parent.right
                bottomMargin: height_margin
                rightMargin: width_margin
            }
            MouseArea{
                anchors.fill: parent
                onPressed: parent.color=botao_pressionado
                onReleased:{
                    parent.color=botao_solto
                    janela_cadastro.visible=false
                    runScript.console_fill()
                    Calljava.ler_arquivos()
                }
            }
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
