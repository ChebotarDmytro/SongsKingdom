import QtQuick 2.0
import Felgo 3.0
import "../components"

Page {
    id: root

    property bool running: false
    property int duration: 1000

    CircleButton {
        id: songsButtonId
        page: root
        source: "qrc:/assets/felgo-logo.png"
        onClicked: {
            root.navigationStack.push(Qt.resolvedUrl("SongsListPage.qml"))
        }

        NumberAnimation on y {
            id: test1
            running: root.running
            to: songsButtonId.y - songsButtonId.height / 1.5
            duration: root.duration
            easing.type: Easing.Linear
        }
    }

    CircleButton {
        id: musicButtonId
        page: root
        source: "qrc:/assets/felgo-logo.png"

        ParallelAnimation {
            id: musicButtonAnimation
            running: root.running
            NumberAnimation {
                target: musicButtonId
                properties: "y"
                to: musicButtonId.y + musicButtonId.height / 1.5
                duration: root.duration
                easing.type: Easing.Linear
            }
            NumberAnimation {
                target: musicButtonId
                properties: "x"
                to: musicButtonId.x - musicButtonId.width / 1.5
                duration: root.duration
                easing.type: Easing.Linear
            }
        }
    }

    CircleButton {
        id: favoritesButtonId
        page: root
        source: "qrc:/assets/felgo-logo.png"

        ParallelAnimation {
            id: favoritesButtonAnimation
            running: root.running
            NumberAnimation {
                target: favoritesButtonId
                properties: "y"
                to: favoritesButtonId.y + favoritesButtonId.height / 1.5
                duration: root.duration
                easing.type: Easing.Linear
            }
            NumberAnimation {
                target: favoritesButtonId
                properties: "x"
                to: favoritesButtonId.x + favoritesButtonId.width / 1.5
                duration: root.duration
                easing.type: Easing.Linear
            }
        }
    }

    title: qsTr("Songbook")
    right   BarItem: IconButtonBarItem {
        icon: IconType.search
        onClicked: {
            console.log("Clicked on search button")
            test1.restart()
            musicButtonAnimation.restart()
            favoritesButtonAnimation.restart()
        }
    }
}
