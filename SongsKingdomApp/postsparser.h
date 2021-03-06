#ifndef POSTSPARSER_H
#define POSTSPARSER_H

#include <QObject>
#include <QJsonObject>

#include <QGumboParser/qgumbonode.h>

class PostsParser
{
public:
//    static bool parse(QGumboNode root);
    static QList<QJsonObject> result();

    static bool parse(QByteArray data);

private:
    PostsParser(){};

    static QJsonObject contentParse(QJsonObject content);

    static QList<QJsonObject> m_result;
};

#endif // POSTSPARSER_H
