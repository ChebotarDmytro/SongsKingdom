import QtQuick 2.0
import QtQuick.Layouts 1.13
import QtGraphicalEffects 1.12
import Felgo 3.0

Rectangle {
    id: root
    property alias source: imageId.source
    property alias title: titleId.text
    property var videoIds: [ ]

    signal openPage()

    height: columnId.height
    width: !parent ? 0 : parent.width
    radius: dp(10)
    border {
        width: dp(1)
        color: "#E8E8E8"
    }
    layer.enabled: true
    layer.effect: DropShadow {
        transparentBorder: true
        verticalOffset: dp(1)
        color: "#E8E8E8"
        radius: dp(4)
        samples: 9
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.openPage();
        }
    }

    ColumnLayout {
        id: columnId
        width: parent.width

        AppImage {
            id: imageId
            visible: source == "qrc:/assets/no-image.png" ?  false : true
            Layout.fillWidth: true
            fillMode: Image.PreserveAspectFit
            sourceSize.width: parent.width
            sourceSize.height: parent.width / 4
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Item {
                    width: imageId.width
                    height: imageId.height
                    Rectangle {
                        anchors.centerIn: parent
                        width: imageId.width
                        height: imageId.height
                        radius: dp(5)
                    }
                }
            }
        }

        YouTubeWebPlayer {
            Layout.fillWidth: true
            visible: !imageId.visible
            videoId: videoIds.length > 0 ? videoIds[0] : "Invalid"
            enabled: false
        }

        AppText {
            id: titleId
            Layout.fillWidth: true
            Layout.margins: dp(5)
            wrapMode: Text.WordWrap
            color: Theme.textColor
            textFormat: Text.RichText
            font.pixelSize: sp(Theme.listItem.fontSizeText)
        }
    }
}
