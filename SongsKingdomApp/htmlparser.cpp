#include "htmlparser.h"

#include <QJsonObject>
#include <QDebug>

#include <QGumboParser/qgumbodocument.h>

QList<QJsonObject> HtmlParser::m_result;

bool HtmlParser::parse(QGumboNode root)
{
    auto postThumbnailObjects = postThumbnail(root);
    auto postTitleObjects = postTitle(root);

    if(postThumbnailObjects.size() != postTitleObjects.size())
    {
        qDebug() << Q_FUNC_INFO << "Error: incorrect size";
        return false;
    }

    for(int i = 0; i < postThumbnailObjects.size(); i++)
    {
        QJsonObject totalObject;
        totalObject["href"] = postThumbnailObjects[i].value("href").toString();
        totalObject["src"] = postThumbnailObjects[i].value("src").toString();

        totalObject["title"] = postTitleObjects[i].value("title").toString();

        m_result.append(totalObject);
    }

    return true;
}

QList<QJsonObject> HtmlParser::result()
{
    return m_result;
}

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
                jsonObject["href"] = node.getAttribute("href");

                auto nodeChildren = node.children();
                auto nodeNodeChildren = nodeChildren.front();

                if(nodeNodeChildren.tag() == HtmlTag::IMG)
                {
                    jsonObject["src"] = nodeNodeChildren.getAttribute("src");
                }
            }
        }

        listObject.append(jsonObject);
    }

    return listObject;
}

QList<QJsonObject> HtmlParser::postTitle(QGumboNode root)
{
    auto container = root.getElementsByClassName("post-title");

    QList<QJsonObject> listObject;

    for(const auto& className : container)
    {
        QJsonObject jsonObject;

        auto children = className.children();

        for (const auto& node: children)
        {
            if(node.tag() == HtmlTag::A)
            {
                jsonObject["title"] = node.innerText();
            }
        }

        listObject.append(jsonObject);
    }

    return listObject;
}
