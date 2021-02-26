import QtQuick 2.0
import Felgo 3.0
import "../components"

ListPage {

    title: qsTr("ICC")
    listView.spacing: 10
    model: htmlModel

    delegate: PostRow {
        _source: imageUrl
        _title: title
    }
}
