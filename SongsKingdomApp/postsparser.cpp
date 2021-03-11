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
                resultObject["videoId"] = content.value("videoId");

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

    QJsonObject resultObject;

    // parse the <p> </p> tags
    auto paragraphParse = [&resultObject, &root]() -> void
    {
        auto container = root.getElementsByTagName(HtmlTag::P);
        QString result;

        for(const auto& node : container)
        {
            if(node.tag() == HtmlTag::P)
            {
                result += node.outerHtml();
            }
        }
        resultObject["text"] = result;
    };

    // parse the wp-block-image class
    auto wpBlockImageParse = [&resultObject, &root]() -> void
    {
        auto container = root.getElementsByClassName("wp-block-image");
        if(!container.empty())
        {
            auto children = container.front().children();

            auto node = children.front();
            if(!node.children().empty())
            {
                auto imgNode = node.children().front();

                if(imgNode.tag() == HtmlTag::IMG)
                {
                    resultObject["src"] = imgNode.getAttribute("src");
                }
            }
            else // IMG
            {
                if(node.tag() == HtmlTag::IMG)
                {
                    resultObject["src"] = node.getAttribute("src");
                }
            }
        }
        else // Empty container
        {
            qDebug() << Q_FUNC_INFO << "Empty container";
            resultObject["src"] = QJsonValue("qrc:/assets/no-image.png");
        }
    };

    auto videoContainerParse = [&resultObject, &root]() -> void
    {
        auto container = root.getElementsByClassName("video-container");
        if(!container.empty())
        {
            QJsonArray videoIdArray = resultObject["videoId"].toArray();
            for(size_t i = 0; i < container.size(); i++)
            {
                QJsonObject videoIdObject;

                auto node = container.at(i);
                if(!node.children().empty())
                {
                    auto iframeNode = node.children().front();
                    if(iframeNode.tag() == HtmlTag::IFRAME)
                    {
                        auto key = QString("videoId%1").arg(i);
                        videoIdObject[key] = videoId(iframeNode.getAttribute("src"));
                    }
                }
                videoIdArray.append(videoIdObject);
            }
            resultObject["videoId"] = videoIdArray;
        }
        else // Empty container
        {
            qDebug() << Q_FUNC_INFO << "The video-container is empty";
            resultObject["videoId"] = resultObject["videoId"].toArray();;
        }
    };

    paragraphParse();
    wpBlockImageParse();
    videoContainerParse();

    return resultObject;
}

QString PostsParser::videoId(const QString &url)
{
    QString regEx = R"((?:https?:\/\/)?(?:www\.)?youtu\.?be(?:\.com)?\/?.*(?:watch|embed)?(?:.*v=|v\/|\/)([\w\-_]+)\&?)";
    auto it = QRegularExpression(regEx).globalMatch(url);

    if(!it.isValid()) return {};

    QRegularExpressionMatch match = it.next();
    return match.captured(1);
}
