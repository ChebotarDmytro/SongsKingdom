#ifndef HTMLLOADER_H
#define HTMLLOADER_H

#include <QObject>

class QNetworkAccessManager;
class QNetworkReply;

class HtmlLoader : public QObject
{
    Q_OBJECT
public:
    explicit HtmlLoader(QObject *parent = nullptr);

    Q_INVOKABLE void fetchPage();

signals:
    void dataBufferReady(QByteArray);

private slots:
    void dataReadyRead();
    void dataReadFinished();

private:
    QNetworkAccessManager *m_NetManager = nullptr;
    QNetworkReply *m_NetReply = nullptr;

    QByteArray m_DataBuffer;
};

#endif // HTMLLOADER_H
