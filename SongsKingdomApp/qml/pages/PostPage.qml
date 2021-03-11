import QtQuick 2.0
import QtQuick.Layouts 1.13
import Felgo 3.0

FlickablePage {
    id: root

    property alias postTitle: titleId.text
    property alias postSource: imageId.source
    property alias postText: textId.text
    property var videoIds: [ ]

    title: qsTr("Події ICC")

    flickable.contentHeight: columnId.height
    scrollIndicator.visible: false

    ColumnLayout {
        id: columnId
        width: parent.width

        AppImage {
            id: imageId
            Layout.fillWidth : true
            visible: source == "qrc:/assets/no-image.png" ?  false : true
            fillMode: Image.PreserveAspectFit
            sourceSize.width: parent.width
            sourceSize.height: parent.width / 2
        }

        AppText {
            id: titleId
            Layout.fillWidth : true
            Layout.margins: dp(10)
            wrapMode: Text.WordWrap
            textFormat: Text.RichText
            font.pixelSize: sp(16)
            font.bold: true
        }

        AppText {
            id: textId
            Layout.fillWidth : true
            Layout.leftMargin : dp(10)
            Layout.rightMargin : dp(10)
            Layout.bottomMargin : dp(10)
            visible: text.length > 0 ? true : false
            wrapMode: Text.WordWrap
            textFormat: Text.RichText
            font.pixelSize: sp(14)
        }

        Repeater {
            model: root.videoIds
            YouTubeWebPlayer {
                Layout.fillWidth: true
                Layout.margins: dp(10)
                videoId: modelData
            }
        }
    }
}
