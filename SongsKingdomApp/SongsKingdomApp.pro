# allows to add DEPLOYMENTFOLDERS and links to the Felgo library and QtCreator auto-completion
CONFIG += felgo felgo-live
QT += webview

# uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
# for the remaining steps to build a custom Live Code Reload app see here: https://felgo.com/custom-code-reload-app/
# CONFIG += felgo-live

# Project identifier and version
# More information: https://felgo.com/doc/felgo-publishing/#project-configuration
PRODUCT_IDENTIFIER = com.kievicc.SongsKingdomApp
PRODUCT_VERSION_NAME = 1.0.0
PRODUCT_VERSION_CODE = 1

# Optionally set a license key that is used instead of the license key from
# main.qml file (App::licenseKey for your app or GameWindow::licenseKey for your game)
# Only used for local builds and Felgo Cloud Builds (https://felgo.com/cloud-builds)
# Not used if using Felgo Live
PRODUCT_LICENSE_KEY = ""

qmlFolder.source = qml
DEPLOYMENTFOLDERS += qmlFolder # comment for publishing

assetsFolder.source = assets
DEPLOYMENTFOLDERS += assetsFolder

# Add more folders to ship with the application here

#RESOURCES += resources.qrc # uncomment for publishing

# NOTE: for PUBLISHING, perform the following steps:
# 1. comment the DEPLOYMENTFOLDERS += qmlFolder line above, to avoid shipping your qml files with the application (instead they get compiled to the app binary)
# 2. uncomment the resources.qrc file inclusion and add any qml subfolders to the .qrc file; this compiles your qml files and js files to the app binary and protects your source code
# 3. change the setMainQmlFile() call in main.cpp to the one starting with "qrc:/" - this loads the qml files from the resources
# for more details see the "Deployment Guides" in the Felgo Documentation

# during development, use the qmlFolder deployment because you then get shorter compilation times (the qml files do not need to be compiled to the binary but are just copied)
# also, for quickest deployment on Desktop disable the "Shadow Build" option in Projects/Builds - you can then select "Run Without Deployment" from the Build menu in Qt Creator if you only changed QML files; this speeds up application start, because your app is not copied & re-compiled but just re-interpreted


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    postsloader.cpp \
    postsmodel.cpp \
    postsparser.cpp \


android {
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
    OTHER_FILES += android/AndroidManifest.xml       android/build.gradle
}

ios {
    QMAKE_INFO_PLIST = ios/Project-Info.plist
    OTHER_FILES += $$QMAKE_INFO_PLIST
}

DISTFILES += \
    qml/components/CircleButton.qml \
    qml/components/PostRow.qml \
    qml/components/SongRow.qml \
    qml/pages/MainPage.qml \
    qml/pages/MenuPage.qml \
    qml/pages/PostPage.qml \
    qml/pages/SongsListPage.qml \
    qml/pages/ViewSongPage.qml

RESOURCES += \
    resources.qrc

HEADERS += \
    postsloader.h \
    postsmodel.h \
    postsparser.h

message( $$PWD )

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/libs/release/ -lQGumboParser
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/libs/debug/ -lQGumboParser
else:unix: LIBS += -L$$PWD/libs/ -lQGumboParser

INCLUDEPATH += $$PWD/include
DEPENDPATH += $$PWD/include

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/libs/release/libQGumboParser.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/libs/debug/libQGumboParser.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/libs/release/QGumboParser.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/libs/debug/QGumboParser.lib
else:unix: PRE_TARGETDEPS += $$PWD/libs/libQGumboParser.a

# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH = /home/dimon/Felgo/Felgo/android_armv7

#android {
#ANDROID_DEPLOYMENT_DEPENDENCIES += \
#    jar/ \
#    lib/libQt5Core.so \
#    lib/libQt5Gui.so \
#    lib/libQt5Svg.so \
#    lib/libQt5Network.so \
#    lib/libQt5Qml.so \
#    lib/libQt5Quick.so \
#    lib/libQt5QuickTemplates2.so \
#    lib/libQt5QuickParticles.so \
#    lib/libQt5QuickControls2.so \
#    lib/libQt5AndroidExtras.so \
#    lib/libQt5Svg.so \
#    lib/libQt5Widgets.so \
#    lib/libFelgo.so \
#    lib/libQt5Multimedia.so \
#    lib/libQt5Sql.so \
#    lib/libFelgoLive.so \
#    lib/libQt53DCore.so \
#    lib/libQt53DExtras.so \
#    lib/libQt53DInput.so \
#    lib/libQt53DLogic.so \
#    lib/libQt53DQuick.so \
#    lib/libQt53DRender.so \
#    lib/libQt5Bluetooth.so \
#    lib/libQt5Charts.so \
#    lib/libQt5Concurrent.so \
#    lib/libQt5Gamepad.so \
#    lib/libQt5Location.so \
#    lib/libQt5Nfc.so \
#    lib/libQt5Positioning.so \
#    lib/libQt5PositioningQuick.so \
#    lib/libQt5Sensors.so \
#    lib/libQt5WebSockets.so \
#    lib/libQt5WebView.so \
#    plugins/bearer/libqandroidbearer.so \
#    plugins/qmltooling/libqmldbg_debugger.so \
#    plugins/qmltooling/libqmldbg_inspector.so \
#    plugins/qmltooling/libqmldbg_local.so \
#    plugins/qmltooling/libqmldbg_native.so \
#    plugins/qmltooling/libqmldbg_profiler.so \
#    plugins/qmltooling/libqmldbg_quickprofiler.so \
#    plugins/qmltooling/libqmldbg_server.so \
#    plugins/qmltooling/libqmldbg_tcp.so \
#    plugins/platforms/android/libqtforandroid.so \
#    plugins/iconengines/libqsvgicon.so \
#    plugins/imageformats/libqgif.so \
#    plugins/imageformats/libqicns.so \
#    plugins/imageformats/libqico.so \
#    plugins/imageformats/libqjpeg.so \
#    plugins/imageformats/libqsvg.so \
#    plugins/imageformats/libqtga.so \
#    plugins/imageformats/libqtiff.so \
#    plugins/imageformats/libqwbmp.so \
#    plugins/imageformats/libqwebp.so \
#    qml/Felgo/felgo.qmltypes \
#    qml/Felgo/qmldir \
#    qml/Felgo/core/App.qml \
#    qml/QtQuick.2/qmldir \
#    qml/QtQuick.2/libqtquick2plugin.so \
#    qml/QtQuick.2/plugins.qmltypes \
#    qml/QtQuick/Dialogs/libdialogplugin.so \
#    qml/QtQuick/Dialogs/plugins.qmltypes \
#    qml/QtQuick/Dialogs/Private/libdialogsprivateplugin.so \
#    qml/QtQuick/Dialogs/Private/plugins.qmltypes \
#    qml/QtQuick/Dialogs/Private/qmldir \
#    qml/QtQuick/Dialogs/qmldir \
#    qml/Qt/labs/folderlistmodel/libqmlfolderlistmodelplugin.so \
#    qml/Qt/labs/folderlistmodel/plugins.qmltypes \
#    qml/Qt/labs/folderlistmodel/qmldir \
#    qml/QtQuick/Templates.2/libqtquicktemplates2plugin.so \
#    qml/QtQuick/Templates.2/plugins.qmltypes \
#    qml/QtQuick/Templates.2/qmldir \
#    qml/QtQuick/Controls.2/qmldir \
#    qml/QtQuick/Controls.2/libqtquickcontrols2plugin.so \
#    qml/QtQuick/Controls.2/Material/qmldir \
#    qml/QtQuick/Controls.2/Material/plugins.qmltypes \
#    qml/QtQuick/Controls.2/Material/libqtquickcontrols2materialstyleplugin.so \
#    qml/QtQuick/Controls.2/Menu.qml \
#    qml/QtQuick/Controls.2/Slider.qml \
#    qml/QtQuick/Controls.2/ToolButton.qml \
#    qml/QtQuick/Controls.2/TextArea.qml \
#    qml/QtQuick/Controls.2/Page.qml \
#    qml/QtQuick/Controls.2/ScrollIndicator.qml \
#    qml/QtQuick/Controls.2/Frame.qml \
#    qml/QtQuick/Controls.2/Action.qml \
#    qml/QtQuick/Controls.2/Drawer.qml \
#    qml/QtQuick/Controls.2/TabButton.qml \
#    qml/QtQuick/Controls.2/Button.qml \
#    qml/QtQuick/Controls.2/StackView.qml \
#    qml/QtQuick/Controls.2/Switch.qml \
#    qml/QtQuick/Controls.2/Label.qml \
#    qml/QtQuick/Controls.2/RangeSlider.qml \
#    qml/QtQuick/Controls.2/Dial.qml \
#    qml/QtQuick/Controls.2/ProgressBar.qml \
#    qml/QtQuick/Controls.2/Popup.qml \
#    qml/QtQuick/Controls.2/ToolBar.qml \
#    qml/QtQuick/Controls.2/Material/CursorDelegate.qml \
#    qml/QtQuick/Controls.2/SwitchDelegate.qml \
#    qml/QtQuick/Controls.2/MenuItem.qml \
#    qml/QtQuick/Controls.2/RadioButton.qml \
#    qml/QtQuick/Controls.2/Tumbler.qml \
#    qml/QtQuick/Controls.2/CheckBox.qml \
#    qml/QtQuick/Controls.2/ApplicationWindow.qml \
#    qml/QtQuick/Controls.2/ItemDelegate.qml \
#    qml/QtQuick/Controls.2/TabBar.qml \
#    qml/QtQuick/Controls.2/ComboBox.qml \
#    qml/QtQuick/Controls.2/RadioDelegate.qml \
#    qml/QtQuick/Controls.2/SpinBox.qml \
#    qml/QtQuick/Controls.2/GroupBox.qml \
#    qml/QtQuick/Controls.2/SwipeDelegate.qml \
#    qml/QtQuick/Controls.2/CheckDelegate.qml \
#    qml/QtQuick/Controls.2/SwipeView.qml \
#    qml/QtQuick/Controls.2/BusyIndicator.qml \
#    qml/QtQuick/Controls.2/TextField.qml \
#    qml/QtQuick/Controls.2/Pane.qml \
#    qml/QtQuick/Controls.2/ToolTip.qml \
#    qml/QtQuick/Controls.2/ScrollBar.qml \
#    qml/QtQuick/Controls.2/Material/Menu.qml \
#    qml/QtQuick/Controls.2/Material/Slider.qml \
#    qml/QtQuick/Controls.2/Material/ToolButton.qml \
#    qml/QtQuick/Controls.2/Material/TextArea.qml \
#    qml/QtQuick/Controls.2/Material/Page.qml \
#    qml/QtQuick/Controls.2/Material/ScrollIndicator.qml \
#    qml/QtQuick/Controls.2/Material/Frame.qml \
#    qml/QtQuick/Controls.2/Material/Drawer.qml \
#    qml/QtQuick/Controls.2/Material/RectangularGlow.qml \
#    qml/QtQuick/Controls.2/Material/ElevationEffect.qml \
#    qml/QtQuick/Controls.2/Material/TabButton.qml \
#    qml/QtQuick/Controls.2/Material/Button.qml \
#    qml/QtQuick/Controls.2/Material/SliderHandle.qml \
#    qml/QtQuick/Controls.2/Material/StackView.qml \
#    qml/QtQuick/Controls.2/Material/Switch.qml \
#    qml/QtQuick/Controls.2/Material/Label.qml \
#    qml/QtQuick/Controls.2/Material/RangeSlider.qml \
#    qml/QtQuick/Controls.2/Material/Dial.qml \
#    qml/QtQuick/Controls.2/Material/ProgressBar.qml \
#    qml/QtQuick/Controls.2/Material/CheckIndicator.qml \
#    qml/QtQuick/Controls.2/Material/Popup.qml \
#    qml/QtQuick/Controls.2/Material/ToolBar.qml \
#    qml/QtQuick/Controls.2/Material/SwitchDelegate.qml \
#    qml/QtQuick/Controls.2/Material/RadioIndicator.qml \
#    qml/QtQuick/Controls.2/Material/MenuItem.qml \
#    qml/QtQuick/Controls.2/Material/RadioButton.qml \
#    qml/QtQuick/Controls.2/Material/Tumbler.qml \
#    qml/QtQuick/Controls.2/Material/CheckBox.qml \
#    qml/QtQuick/Controls.2/Material/ApplicationWindow.qml \
#    qml/QtQuick/Controls.2/Material/ItemDelegate.qml \
#    qml/QtQuick/Controls.2/Material/TabBar.qml \
#    qml/QtQuick/Controls.2/Material/BoxShadow.qml \
#    qml/QtQuick/Controls.2/Material/ComboBox.qml \
#    qml/QtQuick/Controls.2/Material/RadioDelegate.qml \
#    qml/QtQuick/Controls.2/Material/SpinBox.qml \
#    qml/QtQuick/Controls.2/Material/GroupBox.qml \
#    qml/QtQuick/Controls.2/Material/SwipeDelegate.qml \
#    qml/QtQuick/Controls.2/Material/CheckDelegate.qml \
#    qml/QtQuick/Controls.2/Material/SwipeView.qml \
#    qml/QtQuick/Controls.2/Material/BusyIndicator.qml \
#    qml/QtQuick/Controls.2/Material/TextField.qml \
#    qml/QtQuick/Controls.2/Material/Pane.qml \
#    qml/QtQuick/Controls.2/Material/ToolTip.qml \
#    qml/QtQuick/Controls.2/Material/ScrollBar.qml \
#    qml/QtQuick/Controls.2/Material/PageIndicator.qml \
#    qml/QtQuick/Controls.2/PageIndicator.qml \
#    qml/QtQuick/Window.2/libwindowplugin.so \
#    qml/QtQuick/Window.2/plugins.qmltypes \
#    qml/QtQuick/Window.2/qmldir \
#    qml/QtQuick/Layouts/libqquicklayoutsplugin.so \
#    qml/QtQuick/Layouts/plugins.qmltypes \
#    qml/QtQuick/Layouts/qmldir \
#    qml/QtQml/Models.2/libmodelsplugin.so \
#    qml/QtQml/Models.2/plugins.qmltypes \
#    qml/QtQml/Models.2/qmldir \
#    qml/QtQml/plugins.qmltypes \
#    qml/QtQml/qmldir \
#    qml/QtQml/StateMachine/libqtqmlstatemachine.so \
#    qml/QtQml/StateMachine/plugins.qmltypes \
#    qml/QtQml/StateMachine/qmldir \
#    qml/QtQuick/Extras/Private/CircularButton.qml \
#    qml/QtQuick/Extras/Private/CircularButtonStyleHelper.qml \
#    qml/QtQuick/Extras/Private/CircularTickmarkLabel.qml \
#    qml/QtQuick/Extras/Private/Handle.qml \
#    qml/QtQuick/Extras/Private/PieMenuIcon.qml \
#    qml/QtQuick/Extras/Private/qmldir \
#    qml/QtQuick/Extras/Private/TextSingleton.qml \
#    qml/QtGraphicalEffects/Blend.qml \
#    qml/QtGraphicalEffects/BrightnessContrast.qml \
#    qml/QtGraphicalEffects/Colorize.qml \
#    qml/QtGraphicalEffects/ColorOverlay.qml \
#    qml/QtGraphicalEffects/ConicalGradient.qml \
#    qml/QtGraphicalEffects/Desaturate.qml \
#    qml/QtGraphicalEffects/DirectionalBlur.qml \
#    qml/QtGraphicalEffects/Displace.qml \
#    qml/QtGraphicalEffects/DropShadow.qml \
#    qml/QtGraphicalEffects/FastBlur.qml \
#    qml/QtGraphicalEffects/GammaAdjust.qml \
#    qml/QtGraphicalEffects/GaussianBlur.qml \
#    qml/QtGraphicalEffects/Glow.qml \
#    qml/QtGraphicalEffects/HueSaturation.qml \
#    qml/QtGraphicalEffects/InnerShadow.qml \
#    qml/QtGraphicalEffects/LevelAdjust.qml \
#    qml/QtGraphicalEffects/libqtgraphicaleffectsplugin.so \
#    qml/QtGraphicalEffects/LinearGradient.qml \
#    qml/QtGraphicalEffects/MaskedBlur.qml \
#    qml/QtGraphicalEffects/OpacityMask.qml \
#    qml/QtGraphicalEffects/private/DropShadowBase.qml \
#    qml/QtGraphicalEffects/private/FastGlow.qml \
#    qml/QtGraphicalEffects/private/FastInnerShadow.qml \
#    qml/QtGraphicalEffects/private/FastMaskedBlur.qml \
#    qml/QtGraphicalEffects/private/GaussianDirectionalBlur.qml \
#    qml/QtGraphicalEffects/private/GaussianGlow.qml \
#    qml/QtGraphicalEffects/private/GaussianInnerShadow.qml \
#    qml/QtGraphicalEffects/private/GaussianMaskedBlur.qml \
#    qml/QtGraphicalEffects/private/libqtgraphicaleffectsprivate.so \
#    qml/QtGraphicalEffects/private/qmldir \
#    qml/QtGraphicalEffects/qmldir \
#    qml/QtGraphicalEffects/RadialBlur.qml \
#    qml/QtGraphicalEffects/RadialGradient.qml \
#    qml/QtGraphicalEffects/RectangularGlow.qml \
#    qml/QtGraphicalEffects/RecursiveBlur.qml \
#    qml/QtGraphicalEffects/ThresholdMask.qml \
#    qml/QtGraphicalEffects/ZoomBlur.qml \
#    qml/QtQuick/Extras/libqtquickextrasplugin.so \
#    qml/QtQuick/Extras/plugins.qmltypes \
#    qml/QtQuick/Extras/qmldir
#}

