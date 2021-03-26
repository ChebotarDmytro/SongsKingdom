import QtQuick 2.0
import Felgo 3.0

Rectangle {
    id: postImageId

    readonly property bool loaded: webImageId.status === Image.Ready
    readonly property bool loading: webImageId.loading

    property alias image: webImageId
    property alias defaultImage: defaultImageId
    property alias source: webImageId.actualSource

    width: !parent ? 0 : parent.width
    height: dp(200)
    color: Theme.backgroundColor
    border.color: Theme.secondaryTextColor
    border.width: dp(1)

    AppImage {
        id: defaultImageId
        anchors.centerIn: webImageId
        defaultSource: "qrc:/assets/no-image.png"
        visible: !webImageId.visible
    }

    AppImage {
        id: webImageId

        property string actualSource: ""
        property bool loading: false

        anchors.fill: parent
        source: actualSource
        visible: status === Image.Ready
        fillMode: Image.PreserveAspectCrop

        Connections {
            target: webImageId
            onStatusChanged: {
                if(webImageId.status === Image.Loading && !webImageId.loading)
                    webImageId.loading = true
                else if(webImageId.status !== Image.Loading && webImageId.loading)
                    webImageId.loading = false
            }
        }

        // reload image be resetting source property
//        function reload() {
//          webImg.source = ""
//          webImg.source = Qt.binding(function() { return actualSource })
//        }
    }

//    Connections {
//        target: webImageId.status !== Image.Ready ? getApplication() : null
//        onIsOnlineChanged: {
//            console.log("OFFLINE")
//            if(isOnline)
//                webImageId.reload()
//        }
//    }
}
