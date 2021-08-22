import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.LocalStorage 2.0

import QtQuick 2.0
import QtQuick.Controls 2.1

import QtQuick.Extras 1.4

import 'adbCommands.js' as ADB
import 'mainLogic.js' as JS
import 'sqlDatabase.js' as SQL

ApplicationWindow{
    id:appWindow
    width: windowWidth
    height:windowHeight
    x:SQL.windowHandler("window_x")
    y:SQL.windowHandler("window_y")
    minimumHeight: 369
    minimumWidth: 375
    visible: true
    title: applicationTitle

    //  DATABASE
    property string dbId: 'MyData'
    property string dbVersion: '2.0'
    property string dbDescription: 'Database application'
    property int dbsize: 1000000
    property var db

    //  COLORS
    property string myBackground: "#a1a1a1"
    property string myBottomBackground: "#a1a1a1"

    property string buttonPressed: "#d7d7d7"
    property string buttonRealeased: "#545454"

    //  SIZES SETTINGS
    property int windowWidth:SQL.windowHandler("window_width")
    property int windowHeight:SQL.windowHandler("window_height")

    property int debugWindowHeight: 100
    property int debugWindowWidth: 300

    property int buttonWidth:appWindow.width*(45/100)
    property int buttonHeight:appWindow.height*(10/100)

    property int marginWidth:appWindow.width*(2/100)
    property int maginHeight:appWindow.height*(2/100)

    property int cellWidth:appWindow.width*(50/100)
    property int cellHeight:appWindow.height*(25/100)
    property int celula_marca_width:appWindow.width*(1/100)
    property int celula_marca_height:appWindow.height*(1/100)

    property int inputTextHeight:appWindow.height*(10/100)

    //  STRINGS
    property string connectDevice: "CONNECT"
    property string removeDevice: "DISCONNECT"
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
    property var currentPage

    //  POSTITION VARIABLES
    property int posX
    property int posY

    //  DEBUGS
    property string field1: "Debug field 1 -> "+currentPage
    property string field2: "DF 2 > "
    property string field3: "DB 3 > "
    property string field4: "Debug field 4 "
    property string field5: "Debug field 5 "
    property string field6: "Debug field 6 "
    property string field7: "DB 7 > "
    property string field8: "DB 8 > "

    onXChanged: {
        var previousPosX=debug.x
        debug.x=appWindow.x + previousPosX
    }
    onYChanged: {
        var previousPosY=debug.y
        debug.y=appWindow.y+previousPosY
    }

    StackView{
        id:stackView
        anchors.fill:parent
        initialItem: mainPage
        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 500
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 500
            }
        }

        Component{
            id:mainPage
            MainPage{}
        }
        Component{
            id:settingsPage
            SettingsPage{}
        }

        Component.onDestruction: {
            SQL.setSavedData()
        }

    }
}
