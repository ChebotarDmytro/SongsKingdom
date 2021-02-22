#ifndef HTMLPARSER_H
#define HTMLPARSER_H

#include <QObject>
#include <QJsonObject>

#include <QGumboParser/qgumbonode.h>

class HtmlParser
{
public:
    static QList<QJsonObject> postThumbnail(QGumboNode root);
private:
    HtmlParser(){};
};

#endif // HTMLPARSER_H
