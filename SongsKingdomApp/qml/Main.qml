import Felgo 3.0
import QtQuick 2.0
import "pages"

App {
    id: appId

    property bool menuRunning: false

    onInitTheme: {
        //        Theme.navigationBar.backgroundColor = "red"
        Theme.navigationBar.shadowHeight = 0
    }

    onSplashScreenFinished: {
        console.log("start anime")
        menuRunning = true;
    }

    Navigation {
        navigationMode: navigationModeDrawer

        NavigationItem {
            title: qsTr("Home")
            icon: IconType.home

            NavigationStack {
                MenuPage {
                    id: menuId
                    running: menuRunning
                }
            }
        }
    }
}
