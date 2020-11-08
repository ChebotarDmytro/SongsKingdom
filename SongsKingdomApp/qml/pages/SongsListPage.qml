import QtQuick 2.0
import Felgo 3.0
import "../components"

ListPage {
    id: root
    title: qsTr("Songs List")
    // TODO add your model
    model: [{ type: "Fruits", text: "Banana" },
        { type: "Fruits", text: "Apple" },
        { type: "Vegetables", text: "Potato" }]

    section.property: "type"
    delegate: SongRow {
        onClicked: {
            root.navigationStack.push(Qt.resolvedUrl("ViewSongPage.qml"), {nameSong: "Name Song"})
        }
    }
}
