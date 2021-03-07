import QtQuick 2.0
import QtQuick.Layouts 1.13
import Felgo 3.0
import "../components"

ListPage {
    id: root

    function fetchPosts()
    {
        if(postsLoader.isConnection()) {
            console.log("connection good");
            badConnectionId.visible = false;
            busyIndicatorId.visible = true;
            postsLoader.fetchPosts();
        } else {
            console.log("connection bad");
            busyIndicatorId.visible = false;
            badConnectionId.visible = true;
        }
    }

    function openPostPage(model) {
        if(!root.navigationStack.contains(postPageId)) {
            var properties = { postTitle: model.postTitle,
                               postSource: model.imageUrl,
                               postText: model.text}
            root.navigationStack.push(postPageId, properties);
        }
    }

    title: qsTr("ICC")
    listView.anchors.margins: dp(10)
    listView.spacing: dp(10)
    listView.scrollIndicatorVisible: false

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
                    fetchPosts();
                }
            }
        }
    }

    model: postsModel
    delegate: PostRow {
        source: imageUrl
        title: postTitle
        onOpenPage: {
            root.openPostPage(model);
        }
    }

    Component {
        id: postPageId
        PostPage {
        }
    }

    Connections {
        target: postsModel
        onLoadingChanged: {
            busyIndicatorId.visible = false;
        }
    }

    Component.onCompleted: {
        fetchPosts();
    }
}
