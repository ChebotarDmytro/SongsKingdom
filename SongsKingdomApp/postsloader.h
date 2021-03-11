#ifndef POSTSLOADER_H
#define POSTSLOADER_H

#include <QObject>

#include "postsmodel.h"

class QNetworkConfigurationManager;
class QNetworkAccessManager;
class QNetworkReply;

class PostsLoader : public QObject
{
    Q_OBJECT
    Q_PROPERTY(PostsModel* model READ model NOTIFY modelChanged)
public:
    explicit PostsLoader(QObject *parent = nullptr);

    Q_INVOKABLE bool isConnection();
    Q_INVOKABLE void fetchPosts();

    PostsModel *model() const;

signals:
    void modelChanged();

private slots:
    void dataReadyRead();
    void dataReadFinished();

private:
    QStringList videoIds(const QJsonArray &array);

private:
    QNetworkConfigurationManager *m_NetConfigManager = nullptr;
    QNetworkAccessManager *m_NetManager = nullptr;
    QNetworkReply *m_NetReply = nullptr;

    QByteArray m_DataBuffer;
    PostsModel* m_Model;
};

#endif // POSTSLOADER_H
