import QtQuick 2.0
import Felgo 3.0

Item {
    id: root

    property alias source: imageId.source
    property Page page: null

    signal clicked()

    width: dp(100); height: width
    x: (page.width - width) / 2
    y: (page.height / 2 - height)

    Rectangle {
        id: circleId
        anchors.fill: parent
        radius: dp(50)
        border { color: "blue"; width: dp(1) }
        opacity: page.running ? 1 : 0

        AppImage {
            id: imageId
            anchors.centerIn: parent
            source: root.source
            sourceSize { width: parent.width / 1.5; height: width }
        }

        Behavior on opacity {
            NumberAnimation {
                duration: page.duration
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.clicked()
//                page.navigationStack.push(counterPageComponent)
            }
        }
    }

    Component {
      id: counterPageComponent
      Page {
        title: "Change Count"
//        property Page target: null

        Column {
          anchors.centerIn: parent

          // buttons to increase or decrease the count, which is displayed on the main page
          AppButton {
            text: "Count ++"
            onClicked: {
//              app.count++
            }
          }
          AppButton {
            text: "Count --"
            onClicked: {
//              app.count--
            }
          }
        }
      }
    }
}
