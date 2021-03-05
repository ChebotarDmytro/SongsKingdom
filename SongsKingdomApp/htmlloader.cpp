#include "htmlloader.h"

#include <QNetworkConfigurationManager>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QUrlQuery>

HtmlLoader::HtmlLoader(QObject *parent) : QObject(parent),
    m_NetConfigManager(new QNetworkConfigurationManager(this)),
    m_NetManager(new QNetworkAccessManager(this))
{

}

bool HtmlLoader::isConnection()
{
    return m_NetConfigManager->isOnline();
}

void HtmlLoader::fetchPage()
{
    //authentication
    QUrlQuery urlQuery;
    urlQuery.addQueryItem("per_page", "10");

    QUrl url("https://kievicc.org/wp-json/wp/v2/posts/");
    url.setUserName("vitalinska");
    url.setPassword("WCKj 4YMp XDIY rS7C 5CgS A8L3");
    url.setQuery(urlQuery);

    QByteArray data = QString("%1:%2").arg(url.userName())
                                      .arg(url.password()).toLocal8Bit().toBase64();
    QString headerData = "Basic " + data;

    // TODO ini. file
    QNetworkRequest request = QNetworkRequest(url);
    request.setRawHeader("Authorization", headerData.toLocal8Bit());

    m_NetReply = m_NetManager->get(request); // TODO delete later
    connect(m_NetReply, &QIODevice::readyRead, this, &HtmlLoader::dataReadyRead);
    connect(m_NetReply, &QNetworkReply::finished, this, &HtmlLoader::dataReadFinished);
}

void HtmlLoader::dataReadyRead()
{
    m_DataBuffer.append(m_NetReply->readAll());
}

void HtmlLoader::dataReadFinished()
{
    if(m_NetReply->error())
    {
        qDebug() << Q_FUNC_INFO << "Error: " << m_NetReply->errorString();
        return;
    }

    emit dataBufferReady(m_DataBuffer);

    m_DataBuffer.clear();
}
