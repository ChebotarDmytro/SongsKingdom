import QtQuick 2.0
import Felgo 3.0

Rectangle {
    id: root

    property StyleSimpleRow style: StyleSimpleRow {}
    property alias _source: imageId.source
    property alias _title: titleId.text

    height: columnId.height
    width: !parent ? 0 : parent.width
    color: "red"//style.backgroundColor

    Column {
        id: columnId
        anchors.centerIn: parent
        spacing: 10 //dp(Theme.navigationBar.defaultBarItemPadding)

        AppImage {
            id: imageId
            height: 245 // TODO
            fillMode: Image.PreserveAspectFit
            source: root.source
        }

        AppText {
            id: titleId
            height: 100
            elide: Text.ElideRight
            color: Theme.secondaryTextColor
            text: root.title
            maximumLineCount: 2
            font.pixelSize: sp(12)
            opacity: 0.75
        }
    }
}
