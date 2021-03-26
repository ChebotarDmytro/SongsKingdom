import QtQuick 2.0
import QtQuick.Layouts 1.13
import Felgo 3.0
import "../components"

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

        PostImage {
            id: imageId
            Layout.fillWidth : true
            image.sourceSize.width: 0
            border.width: 0
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
