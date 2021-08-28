import QtQuick.Controls 2.15
import QtQuick 2.0

Item {
    id: root
    anchors.fill: parent
    function teste() {
        console.debug(consoleLogLineNumbers)
    }
    Rectangle {
        anchors.fill: parent
        color: noColor
        border.width: 1
        border.color: consoleBorderColor
        ScrollView {
            id: pageScroll
            anchors.fill: parent
            contentHeight: consoleLogLineNumbers * 40
            clip: true
            Text {
                text: consoleLog.text
                textFormat: Text.RichText
                minimumPixelSize: 1
                color: consoleBorderColor
                lineHeight: 0.5
            }
        }
    }
}
