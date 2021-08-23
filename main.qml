import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.LocalStorage 2.0

import QtQuick 2.0
import QtQuick.Controls 2.12

import QtQuick.Extras 1.4

import "adbCommands.js" as ADB
import "mainLogic.js" as JS
import "sqlDatabase.js" as SQL

ApplicationWindow {
    id: appWindow
    width: windowWidth
    height: windowHeight
    x: SQL.windowHandler("window_x")
    y: SQL.windowHandler("window_y")
    minimumHeight: 369
    minimumWidth: 375
    visible: true
    title: applicationTitle + version

    //  VERSION
    property string version: " v1.0.5.4"

    //  DATABASE
    property string dbId: 'MyData'
    property string dbVersion: '2.0'
    property string dbDescription: 'Database application'
    property int dbsize: 1000000
    property var db

    //  COLORS
    property string myBackground: "#3c3c3c"
    property string myMenuBar: "#606060"
    property string consoleColor: "#181818"
    property string consoleBorderColor: "#6c6c6c"
    property string consoleTitleColor: "#0c0c0c"
    property string noColor: "#00000000"

    property string buttonPressed: "#d7d7d7"
    property string buttonRealeased: "#545454"

    property string textColor: "white"

    //  SIZES SETTINGS
    property int windowWidth: SQL.windowHandler("window_width")
    property int windowHeight: SQL.windowHandler("window_height")

    property int debugWindowHeight: 100
    property int debugWindowWidth: 300

    property int menuWidth: 100

    property int buttonWidth: appWindow.width * (45 / 100)
    property int buttonHeight: appWindow.height * (10 / 100)

    property int marginWidth: appWindow.width * (2 / 100)
    property int marginHeight: appWindow.height * (2 / 100)

    property int cellWidthProp: appWindow.width * (50 / 100)
    property int cellHeightProp: appWindow.height * (25 / 100)
    property int celula_marca_width: appWindow.width * 0.008
    property int celula_marca_height: appWindow.height * 0.008

    property int inputTextHeight: appWindow.height * 0.08



    //  STRINGS
    property string connectDevice: "CONNECT"
    property string removeDevice: "DISCONNECT"
    property string arrow: "▶"
    property string selectionText: "SELECT"
    property string searchButtonText: "SEARCH"
    property string backButtonText: "BACK"
    property string searchHint: "Wich device are you looking for?"
    property string addDevice: "ADD DEVICE"
    property string loadDevice: "CARREGAR DO DISPOSITIVO CONECTADO"
    property string setWifi: "ACTIVATE WI-FI"
    property string toSettingsPage: "SETTINGS"
    property string previousPage: "BACK"
    property string applicationTitle: "Android Debug Bridge - Manager"

    //  CONTROL VARIABLES
    property bool click
    property bool lockPosition
    property bool mainPageFirstTime
    property bool settingsPAgeFirstTime
    property bool debugStarted
    property bool remoteImageSelected
    property var currentPage
    property var imageSelection

    property int maximumImageResults: 10

    //  POSTITION VARIABLES
    property int posX
    property int posY

    //  ACTIONS
    function mainActions(actionSelected) {
        switch (actionSelected) {
        case 0:
            appWindow.close()
            break
        }
    }
    property int close_window: 0

    //  DEBUGS
    Page {
        visible: false
        property alias debug_field_1: debug_field_1
        Text {
            id: debug_field_1
        }
        property alias debug_field_2: debug_field_2
        Text {
            id: debug_field_2
        }
        property alias debug_field_3: debug_field_3
        Text {
            id: debug_field_3
        }
        property alias debug_field_4: debug_field_4
        Text {
            id: debug_field_4
        }
        property alias debug_field_5: debug_field_5
        Text {
            id: debug_field_5
        }
        property alias debug_field_6: debug_field_6
        Text {
            id: debug_field_6
        }
        property alias debug_field_7: debug_field_7
        Text {
            id: debug_field_7
        }
        property alias debug_field_8: debug_field_8
        Text {
            id: debug_field_8
        }
    }

    //  GLOBAL CONTROL VARIABLES
    Page {
        visible: false
        property alias loading_gif_visibility: loading_gif_visibility
        Text {
            id: loading_gif_visibility
        }
        property alias loading_text_visibility: loading_text_visibility
        Text {
            id: loading_text_visibility
        }
        property alias loading_text_context: loading_text_context
        Text {
            id: loading_text_context
        }
        property alias console_title_text: console_title_text
        Text {
            id: console_title_text
        }
        property alias console_area_text: console_area_text
        Text {
            id: console_area_text
        }
        property alias loading_timer_control: loading_timer_control
        Text {
            id: loading_timer_control
        }
        property alias loading_iamge_gif_visibility: loading_iamge_gif_visibility
        Text {
            id: loading_iamge_gif_visibility
        }
    }

    Timer{
        id: killDelay
        interval: 1000
        repeat: false
        onTriggered: {
            runScript.console_fill()
        }
    }

    onXChanged: {
        var previousPosX = debug.x
        debug.x = appWindow.x + previousPosX
    }
    onYChanged: {
        var previousPosY = debug.y
        debug.y = appWindow.y + previousPosY
    }

    Component.onCompleted: {
        runScript.console_fill()
        ADB.load_content()
    }
    StackView {
        id: stackView
        anchors {
            top: globalMenu.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        initialItem: mainPage
        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 500
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 500
            }
        }

        Component {
            id: mainPage
            MainPage {}
        }
        Component {
            id: settingsPage
            SettingsPage {}
        }

        Component.onDestruction: {
            SQL.setSavedData()
        }
    }

    Item {
        id: globalMenu
        height: parent.height * 0.05
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        Rectangle {
            id: globalMenuContainer
            color: myMenuBar
            anchors.fill: parent
            border.width: 1
        }

        Rectangle {
            id: subMenuFile
            color: "#00000000"
            border.width: 1
            width: menuWidth
            height: globalMenuContainer.height
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
            }
            Text {
                anchors.fill: parent
                anchors.leftMargin: 5
                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
                text: "<u>A</u>rquivos"
                textFormat: Text.RichText
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    contextFile.open()
                }
                Menu {
                    id: contextFile
                    y: (parent.height)
                    enter: Transition {
                        ParallelAnimation {
                            NumberAnimation {
                                property: "height"
                                from: 0
                                to: contextFile.implicitHeight
                                duration: 100
                            }
                            NumberAnimation {
                                property: "width"
                                from: 0
                                to: contextFile.implicitWidth
                                duration: 100
                            }
                        }
                    }
                    exit: Transition {
                        ParallelAnimation {
                            NumberAnimation {
                                property: "height"
                                from: contextFile.implicitHeight
                                to: 0
                                duration: 100
                            }
                            NumberAnimation {
                                property: "width"
                                from: contextFile.implicitWidth
                                to: 0
                                duration: 100
                            }
                        }
                    }

                    MenuItem {
                        text: "Import Database"
                        onClicked: {
                        }
                    }
                    MenuItem {
                        text: "Export Database"
                        onClicked: {
                        }
                    }
                    MenuSeparator{
                        padding: 0
                        topPadding: 12
                        bottomPadding: 12
                        contentItem: Rectangle {
                            implicitWidth: 200
                            implicitHeight: 1
                            color: "#1E000000"
                        }
                    }
                    MenuItem {
                        text: "Add new device"
                        onClicked: {
                            stackView.push(settingsPage)
                        }
                    }
                    MenuItem {
                        text: "Remove device"
                        onClicked: {
                            mainActions(close_window)
                        }
                    }
                    MenuSeparator{
                        padding: 0
                        topPadding: 12
                        bottomPadding: 12
                        contentItem: Rectangle {
                            implicitWidth: 200
                            implicitHeight: 1
                            color: "#1E000000"
                        }
                    }
                    MenuItem {
                        text: "Exit"
                        onClicked: {
                        }
                    }
                }
            }
        }

        Rectangle {
            id: subMenuDevice
            color: "#00000000"
            border.width: 1
            width: menuWidth
            height: globalMenuContainer.height
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: subMenuFile.right
            }
            Text {
                anchors.fill: parent
                anchors.leftMargin: 5
                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
                text: "<u>D</u>ispositivos"
                textFormat: Text.RichText
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    contextDevice.open()
                }
                Menu {
                    id: contextDevice
                    y: (parent.height)
                    enter: Transition {
                        ParallelAnimation {
                            NumberAnimation {
                                property: "height"
                                from: 0
                                to: contextFile.implicitHeight
                                duration: 100
                            }
                            NumberAnimation {
                                property: "width"
                                from: 0
                                to: contextFile.implicitWidth
                                duration: 100
                            }
                        }
                    }
                    exit: Transition {
                        ParallelAnimation {
                            NumberAnimation {
                                property: "height"
                                from: contextFile.implicitHeight
                                to: 0
                                duration: 100
                            }
                            NumberAnimation {
                                property: "width"
                                from: contextFile.implicitWidth
                                to: 0
                                duration: 100
                            }
                        }
                    }

                    MenuItem {
                        text: "Search for connection"
                        onClicked: {
                            runScript.console_fill()
                            loading_gif_visibility.text = "true"
                            loading_text_visibility.text = "true"
                            loading_text_context.text = "Loading ..."
                            loading_timer_control.text = "true"
                        }
                    }
                    MenuItem {
                        text: "Add new device"
                        onClicked: {
                            stackView.push(settingsPage)
                        }
                    }
                    MenuItem {
                        text: "Remove device"
                        onClicked: {
                        }
                    }
                    MenuSeparator{
                        padding: 0
                        topPadding: 12
                        bottomPadding: 12
                        contentItem: Rectangle {
                            implicitWidth: 200
                            implicitHeight: 1
                            color: "#1E000000"
                        }
                    }
                    MenuItem {
                        text: "Set Wi-fi connection"
                        onClicked: {
                            runScript.setWifiConnection()
                        }
                    }
                    MenuItem {
                        text: "Disconnect Wi-fi connection"
                        onClicked: {
                            runScript.desconectar_dispositivos()
                        }
                    }
                    MenuItem {
                        text: "Kill server"
                        onClicked: {
                            runScript.desconectar_dispositivos()
                            killDelay.start()
                        }
                    }
                }
            }
        }

        Rectangle {
            id: subMenuHelp
            color: "#00000000"
            border.width: 1
            width: menuWidth
            height: globalMenuContainer.height
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: subMenuDevice.right
            }
            Text {
                anchors.fill: parent
                anchors.leftMargin: 5
                horizontalAlignment: Qt.AlignLeft
                verticalAlignment: Qt.AlignVCenter
                text: "<u>A</u>juda"
                textFormat: Text.RichText
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    contextHelp.open()
                }
                Menu {
                    id: contextHelp
                    y: (parent.height)
                    enter: Transition {
                        ParallelAnimation {
                            NumberAnimation {
                                property: "height"
                                from: 0
                                to: contextFile.implicitHeight
                                duration: 100
                            }
                            NumberAnimation {
                                property: "width"
                                from: 0
                                to: contextFile.implicitWidth
                                duration: 100
                            }
                        }
                    }
                    exit: Transition {
                        ParallelAnimation {
                            NumberAnimation {
                                property: "height"
                                from: contextFile.implicitHeight
                                to: 0
                                duration: 100
                            }
                            NumberAnimation {
                                property: "width"
                                from: contextFile.implicitWidth
                                to: 0
                                duration: 100
                            }
                        }
                    }

                    MenuItem {
                        text: "Manual"
                        onClicked: {

                        }
                    }
                    MenuItem {
                        text: "Contact"
                        onClicked: {

                        }
                    }
                    MenuItem {
                        text: "About"
                        onClicked: {

                        }
                    }
                }
            }
        }
    }
}
