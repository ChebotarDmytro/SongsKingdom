import Felgo 3.0
import QtQuick 2.0
import QtWebView 1.1
import "pages"

App {
    id: appId

    function getApplication() {
        return appId;
    }

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
        id: navigationId
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

//            NavigationStack {
//                Page {
//                    Text {
//                        anchors.fill: parent
//                        id: name
//                        textFormat: Text.RichText
//                        wrapMode: Text.WordWrap
//                        text: qsTr("<p>Місце:&nbsp;<a href=https://zoom.us/j/5396261476>https://zoom.us/j/5396261476</a></p>")
//                    }

//                }
//            }

            NavigationStack {
                Page {
                  title: "Web View"

                  WebView {
                    anchors.fill: parent
                    url: "https://kievicc.org/"
                    visible: !navigationId.drawer.isOpen
                  }
                }
              }

//            NavigationStack {
//              Page {
//                title: "YouTube Player"

//                YouTubeWebPlayer {
//                  videoId: "KZkw2n2vSm8"
//                }

//              }
//            }
        }
    }
}
