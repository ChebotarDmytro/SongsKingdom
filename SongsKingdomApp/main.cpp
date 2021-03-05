#include <QApplication>
#include <FelgoApplication>

#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <QGumboParser/qgumbodocument.h>
#include <QGumboParser/qgumbonode.h>

#include <QDebug>

#include "htmlmodel.h"
#include "htmlloader.h"
#include "htmlparser.h"

// uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
#include <FelgoLiveClient>

const char* HTML_PAGE = R"~("
                        <!DOCTYPE html>
                        <html>
                        <head>
                        <title>Title text</title>
                        <meta content="">
                        <style></style>
                        </head>
                        <body>
                        <div class="post-thumbnail">
                        <a href="https://kievicc.org/news/gnn-2/">
                        <img
                        width="520"
                        height="245"
                        src="https://kievicc.org/wp-content/uploads/2020/10/gnn2-520x245.jpg"
                        class="attachment-enspire-medium size-enspire-medium wp-post-image"
                        alt=""
                        loading="lazy"
                        srcset="https://kievicc.org/wp-content/uploads/2020/10/gnn2-520x245.jpg 520w, https://kievicc.org/wp-content/uploads/2020/10/gnn2-720x340.jpg 720w"
                        >
                        </a>
                        <div class="square-icon"> <div class="square-icon-inner"> <a href="https://kievicc.org/type/video/"> <i class="fas fa-icon"></i></a></div>
                        </div>
                        </div>

                        <div class="post-thumbnail">
                        <a href="https://kievicc.org/news/gnn-2/">
                        <img
                        width="520"
                        height="245"
                        src="https://kievicc.org/wp-content/uploads/2020/10/gnn2-520x245.jpg"
                        class="attachment-enspire-medium size-enspire-medium wp-post-image"
                        alt=""
                        loading="lazy"
                        srcset="https://kievicc.org/wp-content/uploads/2020/10/gnn2-520x245.jpg 520w, https://kievicc.org/wp-content/uploads/2020/10/gnn2-720x340.jpg 720w"
                        >
                        </a>
                        <div class="square-icon"> <div class="square-icon-inner"> <a href="https://kievicc.org/type/video/"> <i class="fas fa-icon"></i></a></div>
                        </div>
                        </div>

                        </body>
                        </html>
                        ")~";


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    HtmlModel htmlModel;
    HtmlLoader htmlLoader;

    QObject::connect(&htmlLoader, &HtmlLoader::dataBufferReady, [&htmlModel](QByteArray data)
    {
        bool isCorrect = HtmlParser::parse(data);

        if(isCorrect)
        {
            auto result = HtmlParser::result();

            htmlModel.setLoading(true);
            for (const QJsonObject &object : result)
            {
                auto htmlData = QSharedPointer<HtmlData>::create();
                htmlData->setTitle(object.value("title").toString());
                htmlData->setImageUrl(object.value("src").toString());
                htmlData->setText(object.value("text").toString());
                htmlModel.addHtmlData(htmlData);
            }
            htmlModel.setLoading(false);
        }
    });

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
//    felgo.setMainQmlFileName(QStringLiteral("qrc:/qml/Main.qml"));

    engine.rootContext()->setContextProperty("htmlModel", &htmlModel);
    engine.rootContext()->setContextProperty("htmlLoader", &htmlLoader);

    engine.load(QUrl(felgo.mainQmlFileName()));

    // to start your project as Live Client, comment (remove) the lines "felgo.setMainQmlFileName ..." & "engine.load ...",
    // and uncomment the line below
//        FelgoLiveClient client (&engine);

    return app.exec();
}
