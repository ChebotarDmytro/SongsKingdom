#include "htmlparser.h"

#include <QGumboParser/qgumbodocument.h>

#include <QDebug>

QList<QJsonObject> HtmlParser::postThumbnail(QGumboNode root)
{
    auto container = root.getElementsByClassName("post-thumbnail");

    QList<QJsonObject> listObject;

    for(const auto& className : container)
    {
        QJsonObject jsonObject;

        auto children = className.children();

        for (const auto& node: children)
        {
            if(node.tag() == HtmlTag::A)
            {
                qDebug() << "Tag: " << node.tagName();
                qDebug() << "href: " << node.getAttribute("href");
                jsonObject["href"] = node.getAttribute("href");

                auto nodeChildren = node.children();
                auto nodeNodeChildren = nodeChildren.front();

                if(nodeNodeChildren.tag() == HtmlTag::IMG)
                {
                    qDebug() << "test: " << nodeNodeChildren.getAttribute("src");
                    jsonObject["src"] = nodeNodeChildren.getAttribute("src");
                }
            }
        }

        listObject.append(jsonObject);
    }

    return listObject;
}
