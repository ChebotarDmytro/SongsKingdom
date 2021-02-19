#include "datasource.h"

#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QDataStream>

DataSource::DataSource(QObject *parent) : QObject(parent),
    m_NetManager(new QNetworkAccessManager(this)),
    m_DataBuffer(new QByteArray) // TODO delete
{

}

void DataSource::fetchPage()
{
    const QUrl API_ENDPOINT("https://kievicc.org/"); // TODO ini. file
    QNetworkRequest request;
    request.setUrl(API_ENDPOINT);

    m_NetReply = m_NetManager->get(request); // TODO delete later
    connect(m_NetReply, &QIODevice::readyRead, this, &DataSource::dataReadyRead);
    connect(m_NetReply, &QNetworkReply::finished, this, &DataSource::dataReadFinished);
}

void DataSource::dataReadyRead()
{
    m_DataBuffer->append(m_NetReply->readAll());
}

void DataSource::dataReadFinished()
{
    if(m_NetReply->error())
    {
        qDebug() << "Error: " << m_NetReply->errorString();
    }
    else
    {
        QString test;
        QDataStream in(m_DataBuffer, QIODevice::ReadOnly);
        in >> test;
        qDebug() << QString(*m_DataBuffer);
    }
}
