#include "htmlloader.h"

#include <QNetworkConfigurationManager>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>

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
    const QUrl API_ENDPOINT("https://kievicc.org/"); // TODO ini. file
    QNetworkRequest request;
    request.setUrl(API_ENDPOINT);

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
