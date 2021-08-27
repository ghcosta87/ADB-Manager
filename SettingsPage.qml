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

function butonConfirmation(){
//registerDevice
}
Timer{
}
//adicionar aviso de cadastro efetuado

    Rectangle {
        id: janela_cadastro
        color: myBackground
        anchors.fill: parent

        Rectangle {
            id: fields
            color: noColor
            border.width: 1
            border.color: "white"
            anchors.fill: parent
            anchors.bottomMargin: parent.height * 0.55
            TextField {
                id: nome
                text:"Disite o nome do dispositivo"
                height: inputTextHeight
                anchors {
                    top: parent.top
                    topMargin: marginHeight
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
                    topMargin: marginHeight
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
                    topMargin: marginHeight
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
                    topMargin: marginHeight
                    left: parent.left
                    leftMargin: marginWidth
                    right: parent.right
                    rightMargin: marginWidth
                }
                onPressed: clear()
            }
        }

        Rectangle {
            id: loadConnectedDevice
            color: buttonRealeased
            width: (parent.width * 0.515) - (marginWidth)
            height: buttonHeight
            anchors {
                top: fields.bottom
                right: parent.right
                topMargin: marginHeight
                rightMargin: marginWidth
            }
            Text {
                text: loadDevice
                anchors.fill: parent
                color: textColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
                minimumPixelSize: 1
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }

            MouseArea {
                anchors.fill: parent
                onPressed: parent.color = buttonPressed
                onReleased: {
                    parent.color = buttonRealeased
                    //COLOCAR AKI OS SCRIPT PARA CARREGAR OS
                    //DADOS DO APARELHO CONECTADO
                }
            }
        }

        Rectangle {
            id: registerDevice
            color: buttonRealeased
            width: (parent.width * 0.515) - (marginWidth)
            height: buttonHeight
            anchors {
                top: loadConnectedDevice.bottom
                right: parent.right
                topMargin: marginHeight
                rightMargin: marginWidth
            }
            Text {
                id:registerDeviceText
                text: addDevice
                anchors.fill: parent
                color: textColor
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                fontSizeMode: Text.Fit
                minimumPixelSize: 1
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }

            MouseArea {
                anchors.fill: parent
                onPressed: parent.color = buttonPressed
                onReleased: {
                    parent.color = buttonRealeased
                    butonConfirmation()
                    SQL.registerDevice()
                    //COLOCAR AKI OS SCRIPT PARA CARREGAR OS
                    //DADOS DO APARELHO CONECTADO
                }
            }
        }


        Rectangle {
            id: imageSelectionArea
            color: noColor
            anchors {
                top: fields.bottom
                bottom: parent.bottom
                left: parent.left
                right: loadConnectedDevice.left
                topMargin: marginHeight
                bottomMargin: marginHeight
                rightMargin: marginWidth
                leftMargin: marginWidth
            }
            Rectangle {
                id: imageContainer
                anchors.fill: parent
                color: noColor
                border.width: 1
                border.color: consoleBorderColor
                anchors.bottomMargin: marginHeight * 3
                Image {
                    id: grabResultImage
                    visible: !JS.textToBool(loading_iamge_gif_visibility.text)
                    source: "imagens/searchBackground.jpeg"
                    anchors.fill: parent
                    onStatusChanged: {
                        if (grabResultImage.status === grabResultImage.Loading) {
                            console.log("iamge loading")
                            loadingImage.visible = true
                        }
                        if (grabResultImage.status === grabResultImage.Ready) {
                            console.log("iamge ready")
                            loadingImage.visible = false
                        }
                    }
                }
                AnimatedImage {
                    id: loadingImage
                    visible: JS.textToBool(loading_iamge_gif_visibility.text)
                    source: "imagens/loadingBuffering.gif"
                    anchors.fill: parent
                }
            }

            Rectangle {
                id: backwardButton
                color: buttonRealeased
                border.width: 0.5
                border.color: "#6c6c6c"
                width: parent.width / 3
                anchors {
                    top: imageContainer.bottom
                    bottom: parent.bottom
                    left: parent.left
                }
                Text {
                    text: arrow
                    anchors.fill: parent
                    rotation: 180
                    color: textColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 1
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: parent.color = buttonPressed
                    onReleased: {
                        parent.color = buttonRealeased
                        imageSelection--
                        if (imageSelection < 0)
                            imageSelection = 0
                        NET.jsonSpliter("", 1, imageSelection)
                        //COLOCAR AKI OS SCRIPT PARA CARREGAR OS
                        //DADOS DO APARELHO CONECTADO
                    }
                }
            }

            Rectangle {
                id: fwdButton
                color: buttonRealeased
                border.width: 0.5
                border.color: "#6c6c6c"
                width: parent.width / 3
                anchors {
                    top: imageContainer.bottom
                    bottom: parent.bottom
                    right: parent.right
                }
                Text {
                    text: arrow
                    anchors.fill: parent
                    color: textColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 1
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: parent.color = buttonPressed
                    onReleased: {
                        parent.color = buttonRealeased
                        imageSelection++
                        if (imageSelection > maximumImageResults)
                            imageSelection = maximumImageResults
                        NET.jsonSpliter("", 1, imageSelection)
                    }
                }
            }

            Rectangle {
                id: selectButton
                color: buttonRealeased
                border.width: 0.5
                border.color: "#6c6c6c"
                anchors {
                    top: imageContainer.bottom
                    bottom: parent.bottom
                    left: backwardButton.right
                    right: fwdButton.left
                }
                Text {
                    text: selectionText
                    anchors.fill: parent
                    color: textColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 1
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: parent.color = buttonPressed
                    onReleased: {
                        parent.color = buttonRealeased
                        remoteImageSelected=true
                        //PASSA O LINK DA IMAGEM PARA O BANCO DE DADOS
                        //OU SALVA A IMAGEM EM ALGUM LUGAR?
                    }
                }
            }
        }

        Rectangle {
            id: toolBox
            color: textColor
            border.width: 1
            border.color: "white"
            anchors {
                top: registerDevice.bottom
                bottom: parent.bottom
                left: imageSelectionArea.right
                right: parent.right
                topMargin: marginHeight
                bottomMargin: marginHeight
                rightMargin: marginWidth
                leftMargin: marginWidth
            }

            TextArea {
                id: searchBox
                text: searchHint
                height: inputTextHeight*1.2
                wrapMode: Text.WrapAnywhere
                padding: 2
                textFormat: Text.RichText
                anchors {
                    top: parent.top
                    topMargin: marginHeight
                    left: parent.left
                    leftMargin: marginWidth
                    right: parent.right
                    rightMargin: marginWidth
                }
                onPressed: clear()
            }

            Rectangle {
                id: searchButton
                color: buttonRealeased
                width: parent.width * 0.5
                border.width: 0.5
                border.color: "#6c6c6c"
                anchors {
                    top: searchBox.bottom
                    bottom: parent.bottom
                    left: parent.left
                    topMargin: marginHeight * 2
                }
                Text {
                    text: searchButtonText
                    anchors.fill: parent
                    color: textColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 1
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: parent.color = buttonPressed
                    onReleased: {
                        parent.color = buttonRealeased
                        loading_iamge_gif_visibility.text = "true"
                        NET.grabImage(searchBox.getText(0, 50))
                        //PASSA O LINK DA IMAGEM PARA O BANCO DE DADOS
                        //OU SALVA A IMAGEM EM ALGUM LUGAR?
                    }
                }
            }

            Rectangle {
                id: backButton
                color: buttonRealeased
                width: parent.width * 0.5
                border.width: 0.5
                border.color: "#6c6c6c"
                anchors {
                    top: searchBox.bottom
                    bottom: parent.bottom
                    right: parent.right
                    topMargin: marginHeight * 2
                }
                Text {
                    text: backButtonText
                    anchors.fill: parent
                    color: textColor
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    fontSizeMode: Text.Fit
                    minimumPixelSize: 1
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                }

                MouseArea {
                    anchors.fill: parent
                    onPressed: parent.color = buttonPressed
                    onReleased: {
                        parent.color = buttonRealeased
                        stackView.push(mainPage)
                        //PASSA O LINK DA IMAGEM PARA O BANCO DE DADOS
                        //OU SALVA A IMAGEM EM ALGUM LUGAR?
                    }
                }
            }
        }
    }

    StackView {
        id: stackDebug
        x: posX
        y: posY
        width: debugWindowWidth
        height: debugWindowHeight
        initialItem: debugFloatingWindow
        onXChanged: posX = stackDebug.x
        onYChanged: posY = stackDebug.y
    }

    Component {
        id: debugFloatingWindow
        Debug {}
    }
}
