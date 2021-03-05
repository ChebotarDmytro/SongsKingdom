#ifndef HTMLPARSER_H
#define HTMLPARSER_H

#include <QObject>
#include <QJsonObject>

#include <QGumboParser/qgumbonode.h>

class HtmlParser
{
public:
//    static bool parse(QGumboNode root);
    static QList<QJsonObject> result();

    static bool parse(QByteArray data);

private:
    HtmlParser(){};

    static QJsonObject contentParse(QJsonObject content);

    static QList<QJsonObject> m_result;
};

#endif // HTMLPARSER_H
