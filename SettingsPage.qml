import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.LocalStorage 2.0

import QtQuick 2.0
import QtQuick.Controls 2.1

import QtQuick.Extras 1.4

import "adbCommands.js" as ADB
import "mainLogic.js" as JS
import "sqlDatabase.js" as SQL
import "htmlGrab.js" as NET

Item {
    id: settingsItem
    Component.onCompleted: {
        currentPage = 1
        if (!settingsPAgeFirstTime) {
            settingsPAgeFirstTime = true
            posY = appWindow.height * 0.6
            imageSelection = 0
        }
    }

    Rectangle {
        id: janela_cadastro
        color: myBackground
        anchors.fill: parent

        TextField {
            id: nome
            //text:"Disite o nome do dispositivo"
            text: "foto sm-n9600"
            height: inputTextHeight
            anchors {
                top: parent.top
                topMargin: maginHeight
                left: parent.left
                leftMargin: marginWidth
                right: parent.right
                rightMargin: marginWidth
            }
            onPressed: clear()
        }

        TextField {
            id: ip
            text: "Digite o IP do dispositivo"
            height: inputTextHeight
            anchors {
                top: nome.bottom
                topMargin: maginHeight
                left: parent.left
                leftMargin: marginWidth
                right: parent.right
                rightMargin: marginWidth
            }
            onPressed: clear()
        }

        TextField {
            id: image_path
            text: "Digite o caminho completo para o icone"
            height: inputTextHeight
            anchors {
                top: ip.bottom
                topMargin: maginHeight
                left: parent.left
                leftMargin: marginWidth
                right: parent.right
                rightMargin: marginWidth
            }
            onPressed: clear()
        }

        TextField {
            id: descricao
            text: "Adicione a descricao"
            height: inputTextHeight
            anchors {
                top: image_path.bottom
                topMargin: maginHeight
                left: parent.left
                leftMargin: marginWidth
                right: parent.right
                rightMargin: marginWidth
            }
            onPressed: clear()
        }

        Image {
            id: grabResultImage
            width: parent.width * 0.5
            source: "imagens/loading-buffering.gif"
            anchors {
                top: descricao.bottom
                bottom: bottomMenu.top
                left: parent.left
            }
        }

        Rectangle {
            id: bottomMenu
            color: "#00000000"
            height: parent.height * 0.1
            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
            }
            Rectangle {
                id: cadastro_cadastrar
                color: "grey"
                width: (parent.width * 0.515) - (marginWidth)
                height: buttonHeight
                anchors {
                    bottom: parent.bottom
                    left: parent.left
                }
                Text {
                    text: addDevice
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 1
                    wrapMode: Text.WrapAnywhere
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: parent.color = buttonPressed
                    onReleased: {
                        parent.color = buttonRealeased
                        runScript.console_fill()
                        ADB.a05_cadastrar_dispositivo()
                        janela_cadastro.visible = false
                        ADB.a04_carregar_dispositivos()
                        ADB.ler_arquivos()
                    }
                }
            }

            Rectangle {
                id: bottomSeparator
                color: "#827f7f"
                height: parent.height
                border.width: 1
                border.color: "white"
                anchors {
                    bottom: parent.bottom
                    left: cadastro_cadastrar.right
                    right: cadastro_voltar.left
                }
            }

            Rectangle {
                id: cadastro_voltar
                radius: 5
                color: "grey"
                width: (parent.width * 0.515) - (marginWidth)
                height: buttonHeight
                anchors {
                    bottom: parent.bottom
                    right: parent.right
                }
                Text {
                    text: previousPage
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 1
                    wrapMode: Text.WrapAnywhere
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: parent.color = buttonPressed
                    onReleased: {
                        stackView.push(mainPage)
                        parent.color = buttonRealeased
                        janela_cadastro.visible = false
                        runScript.console_fill()
                        ADB.ler_arquivos()
                    }
                }
            }
        }

        Button {
            id: button
            x: 424
            y: 220
            text: qsTr("UPDATE")
            onClicked: {
                NET.grabImage(nome.text)
            }
        }
    }

    StackView {
        id: stackDebug
        x: posX
        y: posY
        //        x: parent.x
        //        y: parent.y
        width: debugWindowWidth
        height: debugWindowHeight
        clip: false
        rotation: 0
        initialItem: debugFloatingWindow
        onXChanged: posX = stackDebug.x
        onYChanged: posY = stackDebug.y
    }

    Button {
        id: selectButton
        x: 110
        y: 392
        text: qsTr("SELECT")
    }

    Button {
        id: backwardButton
        x: 8
        y: 392
        text: qsTr("<")
        onClicked: {
            imageSelection--
            if (imageSelection < 0)imageSelection = 0
            NET.jsonSpliter("",1,imageSelection)
        }
    }

    Button {
        id: fwdButton
        x: 212
        y: 392
        text: qsTr(">")
        onClicked: {
            imageSelection++
            if (imageSelection > 3)imageSelection = 3
            NET.jsonSpliter("",1,imageSelection)
        }
    }

    Component {
        id: debugFloatingWindow
        Debug {}
    }



}
