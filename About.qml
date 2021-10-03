import QtQuick 2.0
import QtQuick.Controls 2.1

import QtQuick.Extras 1.4

Item {
    id: about

//    onNavigationRequested: function(request) {
//        if (request.navigationType === WebEngineNavigationRequest.LinkClickedNavigation) {
//            Qt.openUrlExternally(request.url)
//        }
//        request.action = WebEngineNavigationRequest.IgnoreRequest
//    }

    Rectangle {
        id:aboutContainer
        color: consoleBorderColor
        anchors.fill: parent
        border.width: 1
        border.color: "white"

        Text {
            id: paragraphOne
            height: parent.height*0.4
            textFormat: Text.RichText
            text: "<p><b>ADB Manager " + version + "</b></p>" + "<p></p>" + "<p></p>"
                  + "<p>Based on QT 5.15.2</p>"
            anchors {
                top: parent.top
                left: parent.left
                right: parent.right
                topMargin: marginHeight
                leftMargin: marginWidth
                rightMargin: marginWidth
            }
        }
        Text {
            id: paragraphTwo
            textFormat: Text.RichText
            text:  "<p>Check this repository on my GitHub </p>"
                   + "<p>" + github + "</p>"
                   + "<p>Done by Gabriel H Costa</p>"
            anchors {
                top: paragraphOne.bottom
                bottom: gitIcon.top
                topMargin: marginHeight
                bottomMargin: marginHeight
                leftMargin: marginWidth
                rightMargin: marginWidth
            }
        }
        Image {
            id: gitIcon
            height: parent.height*0.1
            width: gitIcon.height
            source: "imagens/github-original-wordmark.svg"
            anchors{
                left: parent.left
                bottom: parent.bottom
                leftMargin: marginWidth
                bottomMargin: marginHeight
            }
            MouseArea{
                anchors.fill: parent
                onClicked:{

                }
                //                 onLinkActivated: Qt.openUrlExternally(link)
                    //                  text:'<html></style><ahref="http://baidu.com">baidu</a></html>'
            }
        }



        Button {
            width: buttonWidth * 0.5
            height: buttonHeight * 0.5
            text: "CLOSE"
            anchors {
                bottom: parent.bottom
                right: parent.right
                bottomMargin: marginHeight
                rightMargin: marginWidth
            }
            onClicked: aboutStackView.clear(aboutPage)
        }
    }
}
