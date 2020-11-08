import QtQuick 2.0
import Felgo 3.0

Rectangle {
    id: root

    property StyleSimpleRow style: StyleSimpleRow {}
    signal clicked

    height: rowId.height + dp(20)
    width: !parent ? 0 : parent.width
    color: style.backgroundColor

    RippleMouseArea {
        anchors.fill: parent
        circularBackground: false
        onClicked: {
            root.clicked()
        }
    }

    Row {
        id: rowId
        width: parent.width - dp(Theme.navigationBar.defaultBarItemPadding) * 2
        anchors.centerIn: parent
        spacing: dp(Theme.navigationBar.defaultBarItemPadding)

        RoundedImage {
            id: roundedImageId
            width: dp(root.style.fontSizeText) * 2.5; height: width
            radius: width / 2
            border { width:1; color: "blue" }
            img {
                scale: 0.7
                source: "qrc:/assets/felgo-logo.png"
            }
        }

        Column {
            id: columnTextId
            width: parent.width - roundedImageId.width - 2 * rowId.spacing - imageId.width
            anchors.verticalCenter: parent.verticalCenter
            spacing: dp(2)

            AppText {
                width: parent.width
                elide: Text.ElideRight
                text: "Name of Song"
            }

            AppText {
                width: parent.width
                elide: Text.ElideRight
                color: Theme.secondaryTextColor
                text: "Secondary text"
                maximumLineCount: 1
                font.pixelSize: sp(12)
                opacity: 0.75
            }
        }

        AppImage {
            id: imageId
            scale: 0.5
            width: dp(root.style.fontSizeText) * 2.5; height: width
            source: "qrc:/assets/felgo-logo.png"
        }
    }
}
