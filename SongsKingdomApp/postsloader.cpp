#include "postsloader.h"

// network
#include <QNetworkConfigurationManager>
#include <QNetworkAccessManager>
#include <QNetworkReply>
#include <QNetworkRequest>
#include <QUrlQuery>

// json
#include <QJsonArray>
#include <QJsonObject>

#include "postsparser.h"

PostsLoader::PostsLoader(QObject *parent) : QObject(parent),
    m_NetConfigManager(new QNetworkConfigurationManager(this)),
    m_NetManager(new QNetworkAccessManager(this)),
    m_Model(new PostsModel(this))
{

}

bool PostsLoader::isConnection()
{
    return m_NetConfigManager->isOnline();
}

void PostsLoader::fetchPosts()
{
    //authentication
    QUrlQuery urlQuery;
    urlQuery.addQueryItem("per_page", "20"); // TODO 10

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
    connect(m_NetReply, &QIODevice::readyRead, this, &PostsLoader::dataReadyRead);
    connect(m_NetReply, &QNetworkReply::finished, this, &PostsLoader::dataReadFinished);
}

PostsModel *PostsLoader::model() const
{
    return m_Model;
}

void PostsLoader::dataReadyRead()
{
    m_DataBuffer.append(m_NetReply->readAll());
}

void PostsLoader::dataReadFinished()
{
    if(m_NetReply->error())
    {
        qDebug() << Q_FUNC_INFO << "Error: " << m_NetReply->errorString();
        return;
    }

    bool isCorrect = PostsParser::parse(m_DataBuffer);

    if(isCorrect)
    {
        auto result = PostsParser::result();

        m_Model->setLoading(true);
        for (const QJsonObject &object : result)
        {
            auto postData = QSharedPointer<PostData>::create();
            postData->setTitle   ( object.value("title").toString()  );
            postData->setImageUrl( object.value("src").toString()    );
            postData->setText    ( object.value("text").toString()   );
            postData->setVideoIds ( videoIds(object.value("videoId").toArray()) );
            m_Model->addPostData(postData);
        }
        m_Model->setLoading(false);

        emit modelChanged();
    }

    m_NetReply->deleteLater();
    m_DataBuffer.clear();
}

QStringList PostsLoader::videoIds(const QJsonArray &array)
{
    QStringList result;
    for(int i = 0; i < array.size(); i++)
    {
        auto object = array.at(i).toObject();
        auto key = QString("videoId%1").arg(i);
        result << object.value(key).toString();
    }
    return result;
}
