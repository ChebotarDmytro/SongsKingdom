import QtQuick 2.0
import QtQuick.Layouts 1.13
import Felgo 3.0
import "../components"

ListPage {
    id: root

    function fetchPage()
    {
        if(htmlLoader.isConnection()) {
            console.log("connection good");
            badConnectionId.visible = false;
            busyIndicatorId.visible = true;
            htmlLoader.fetchPage();
        } else {
            console.log("connection bad");
            busyIndicatorId.visible = false;
            badConnectionId.visible = true;
        }
    }

    title: qsTr("ICC")
    listView.anchors.margins: dp(10)
    listView.spacing: dp(10)
    listView.scrollIndicatorVisible: false

//    listView.onCurrentIndexChanged: {
//        console.log("currentIndex: ", listView.currentIndex)
////        root.navigationStack.push(Qt.resolvedUrl("MenuPage.qml"))
//    }
//    listView.onCurrentItemChanged: {
//        console.log("onCurrentItemChanged: ")
//    }

    AppActivityIndicator {
        id: busyIndicatorId
        anchors.centerIn: parent
        visible: false
        iconSize: dp(40)
    }

    Rectangle {
        id: badConnectionId
        anchors.centerIn: parent
        color: Theme.backgroundColor
        visible: false

        ColumnLayout {
            anchors.centerIn: parent
            spacing: dp(10)

            AppText {
                Layout.alignment: Qt.AlignCenter
                color: Theme.textColor
                font.pixelSize: Theme.listItem.fontSizeText
                font.bold: true
                text: qsTr("Немає з'єднання з інтернетом")
            }

            AppButton {
                Layout.alignment: Qt.AlignCenter
                text: qsTr("Обновити")
                onClicked: {
                    fetchPage();
                }
            }
        }
    }

    model: htmlModel
    delegate: PostRow {
        _source: imageUrl
        _title: title

        onOpenPage: {
            root.navigationStack.push(Qt.resolvedUrl("SongsListPage.qml"));
        }
    }

    Connections {
        target: htmlModel
        onLoadingChanged: {
            busyIndicatorId.visible = false;
        }
    }

    Component.onCompleted: {
        fetchPage();
    }
}
