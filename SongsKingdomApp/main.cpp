#include <QApplication>
#include <FelgoApplication>

#include <QQmlApplicationEngine>

#include <QGumboParser/qgumbodocument.h>
#include <QGumboParser/qgumbonode.h>

#include <QDebug>

#include "datasource.h"

// uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
//#include <FelgoLiveClient>
const char* HTML_PAGE = R"~("
<!DOCTYPE html>
<html>
  <head>
    <title>Title text</title>
    <meta content="">
    <style></style>
  </head>
  <body>
    <h3>First header</h3>
    <p>text text text</p>
    <div class="content">
        <h3>Nested header <a href="">with link</a></h3>
    </div>
  </body>
</html>
")~";



int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    DataSource data;
    data.fetchPage();

//    auto doc = QGumboDocument::parse(HTML_PAGE);
//    auto root = doc.rootNode();
//    auto nodes = root.getElementsByTagName(HtmlTag::TITLE);
//    Q_ASSERT(nodes.size() == 1);

//    auto title = nodes.front();
//    qDebug() << "title is: " << title.innerText();

//    nodes = root.getElementsByTagName(HtmlTag::H3);
//    for (const auto& node: nodes) {
//        qDebug() << "h3: " << node.innerText();
//    }

//    auto container = root.getElementsByClassName("content");
//    Q_ASSERT(container.size() == 1);

//    auto children = container.front().children();
//    for (const auto& node: children) {
//        qDebug() << "Tag: " << node.tagName();
//    }

    FelgoApplication felgo;

    // Use platform-specific fonts instead of Felgo's default font
    felgo.setPreservePlatformFonts(true);

    QQmlApplicationEngine engine;
    felgo.initialize(&engine);

    // Set an optional license key from project file
    // This does not work if using Felgo Live, only for Felgo Cloud Builds and local builds
    felgo.setLicenseKey(PRODUCT_LICENSE_KEY);

    // use this during development
    // for PUBLISHING, use the entry point below
    felgo.setMainQmlFileName(QStringLiteral("qml/Main.qml"));

    // use this instead of the above call to avoid deployment of the qml files and compile them into the binary with qt's resource system qrc
    // this is the preferred deployment option for publishing games to the app stores, because then your qml files and js files are protected
    // to avoid deployment of your qml files and images, also comment the DEPLOYMENTFOLDERS command in the .pro file
    // also see the .pro file for more details
    //felgo.setMainQmlFileName(QStringLiteral("qrc:/qml/Main.qml"));

    engine.load(QUrl(felgo.mainQmlFileName()));

    // to start your project as Live Client, comment (remove) the lines "felgo.setMainQmlFileName ..." & "engine.load ...",
    // and uncomment the line below
//    FelgoLiveClient client (&engine);

    return app.exec();
}
