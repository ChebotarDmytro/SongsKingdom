import Felgo 3.0
import QtQuick 2.0
import "pages"

App {
    id: appId

    property bool menuRunning: false

    //    onInitTheme: {
    ////        //        Theme.navigationBar.backgroundColor = "red"
    //        Theme.navigationBar.shadowHeight = 0
    //    }

    onSplashScreenFinished: {
        console.log("start anime")
        menuRunning = true;
    }

    Navigation {
        navigationMode: navigationModeDrawer

        NavigationItem {
            title: qsTr("Хороші новини")
            icon: IconType.newspapero

            NavigationStack {
                MainPage {

                }
            }
        }

        NavigationItem {
            title: qsTr("Пісенник")
            icon: IconType.book

            NavigationStack {
                Page {
                    Text {
                        anchors.fill: parent
                        id: name
                        textFormat: Text.RichText
                        wrapMode: Text.WordWrap
                        text: qsTr("<p>Місце:&nbsp;<a href=https://zoom.us/j/5396261476>https://zoom.us/j/5396261476</a></p>")
                    }

                }
            }
        }
    }
}
