import QtQuick 2.0
import QtGraphicalEffects 1.12
import Felgo 3.0

Rectangle {
    id: root
    property alias _source: imageId.source
    property alias _title: titleId.text

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

    Column {
        id: columnId
        anchors.centerIn: parent

        AppImage {
            id: imageId
            height: dp(150)
            width: root.width
            fillMode: Image.PreserveAspectCrop
            source: root.source
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

        AppText {
            id: titleId
            anchors.left: parent.left
            anchors.leftMargin: dp(10)
            height: dp(40)
            width: root.width
            elide: Text.ElideRight
            color: Theme.textColor
            text: root.title
            maximumLineCount: 1
            font.pixelSize: Theme.listItem.fontSizeText
        }
    }
}
