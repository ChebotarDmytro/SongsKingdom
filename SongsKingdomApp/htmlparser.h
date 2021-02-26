#ifndef HTMLPARSER_H
#define HTMLPARSER_H

#include <QObject>
#include <QJsonObject>

#include <QGumboParser/qgumbonode.h>

class HtmlParser
{
public:
    static bool parse(QGumboNode root);
    static QList<QJsonObject> result();

private:
    HtmlParser(){};
    static QList<QJsonObject> postThumbnail(QGumboNode root);
    static QList<QJsonObject> postTitle(QGumboNode root);

    static QList<QJsonObject> m_result;
};

#endif // HTMLPARSER_H
