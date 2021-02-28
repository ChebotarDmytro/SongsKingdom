import QtQuick 2.0
import Felgo 3.0
import "../components"

ListPage {
    title: qsTr("ICC")
    listView.anchors.margins: dp(10)
    listView.spacing: dp(10)
    model: htmlModel

    delegate: PostRow {
        _source: imageUrl
        _title: title
    }
}
