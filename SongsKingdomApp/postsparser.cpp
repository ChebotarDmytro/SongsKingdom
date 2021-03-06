#include "postsparser.h"

#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>

#include <QGumboParser/qgumbodocument.h>

QList<QJsonObject> PostsParser::m_result;

bool PostsParser::parse(QByteArray data)
{
    auto doc = QJsonDocument::fromJson(data);
    if(!doc.isEmpty())
    {
        if(doc.isArray())
        {
            QJsonArray posts = doc.array();

            for(int i = 0; i < posts.size(); i++)
            {
                QJsonObject resultObject;
                QJsonObject post = posts.at(i).toObject();

                QJsonObject title = post["title"].toObject();
                resultObject["title"] = title.value("rendered");

                QJsonObject content = contentParse( post["content"].toObject() );
                resultObject["src"] = content.value("src");
                resultObject["text"] = content.value("text");

                m_result.append(resultObject);
            }
            return true;
        }
    }

    return false;
}

QList<QJsonObject> PostsParser::result()
{
    return m_result;
}

QJsonObject PostsParser::contentParse(QJsonObject content)
{
    auto doc = QGumboDocument::parse(content["rendered"].toString());
    auto root = doc.rootNode();

    QJsonObject jsonObject;

    {
        // parse the <p> </p> tags
        auto container = root.getElementsByTagName(HtmlTag::P);
        QString result;

        for(const auto& node : container)
        {
            if(node.tag() == HtmlTag::P)
            {
                result += node.outerHtml();
            }
        }
        jsonObject["text"] = result;
    }

    {
        // parse the wp-block-image class
        auto container = root.getElementsByClassName("wp-block-image");
        if(container.empty())
        {
            qDebug() << Q_FUNC_INFO << "Empty container";
            jsonObject["src"] = QJsonValue("qrc:/assets/no-image.png");
            return jsonObject;
        }

        auto children = container.front().children();
        if(children.empty())
        {
            qDebug() << Q_FUNC_INFO << "Empty children";
            jsonObject["src"] = QJsonValue("qrc:/assets/no-image.png");
            return jsonObject;
        }

        auto node = children.front();
        if(!node.children().empty())
        {
            auto imgNode = node.children().front();

            if(imgNode.tag() == HtmlTag::IMG)
            {
                jsonObject["src"] = imgNode.getAttribute("src");
            }
        }
        else // IMG
        {
            if(node.tag() == HtmlTag::IMG)
            {
                jsonObject["src"] = node.getAttribute("src");
            }
        }
    }

    return jsonObject;
}
