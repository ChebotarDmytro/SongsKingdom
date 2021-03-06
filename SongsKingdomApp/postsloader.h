#ifndef POSTSLOADER_H
#define POSTSLOADER_H

#include <QObject>

class QNetworkConfigurationManager;
class QNetworkAccessManager;
class QNetworkReply;

class PostsLoader : public QObject
{
    Q_OBJECT
public:
    explicit PostsLoader(QObject *parent = nullptr);

    Q_INVOKABLE bool isConnection();
    Q_INVOKABLE void fetchPosts();

signals:
    void dataBufferReady(QByteArray);

private slots:
    void dataReadyRead();
    void dataReadFinished();

private:
    QNetworkConfigurationManager *m_NetConfigManager = nullptr;
    QNetworkAccessManager *m_NetManager = nullptr;
    QNetworkReply *m_NetReply = nullptr;

    QByteArray m_DataBuffer;
};

#endif // POSTSLOADER_H
