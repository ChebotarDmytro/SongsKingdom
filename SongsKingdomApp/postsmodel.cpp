#include "postsmodel.h"

// PostData

PostData::PostData(QObject *parent) : QObject(parent)
{

}

QString PostData::imageUrl() const
{
    return m_imageUrl;
}

QString PostData::title() const
{
    return m_title;
}

QString PostData::text() const
{
    return m_text;
}

QStringList PostData::videoIds() const
{
    return m_videoIds;
}


void PostData::setImageUrl(QString imageUrl)
{
    if (m_imageUrl == imageUrl)
        return;

    m_imageUrl = imageUrl;
    emit imageUrlChanged(m_imageUrl);
}

void PostData::setTitle(QString title)
{
    if (m_title == title)
        return;

    m_title = title;
    emit titleChanged(m_title);
}

void PostData::setText(QString text)
{
    if (m_text == text)
        return;

    m_text = text;
    emit textChanged(m_text);
}

void PostData::setVideoIds(QStringList videoIds)
{
    if (m_videoIds == videoIds)
        return;

    m_videoIds = videoIds;
    emit videoIdsChanged(m_videoIds);
}

// PostsModel

PostsModel::PostsModel(QObject *parent) : QAbstractListModel(parent)
{

}

int PostsModel::rowCount(const QModelIndex &/*parent*/) const
{
    return m_listData.size();
}

QVariant PostsModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid())
        return {};
    if(index.row() < 0 || index.row() >= m_listData.count())
        return {};

    PostData *postData = m_listData[index.row()].get();
    if(role == ImageUrl)
        return postData->imageUrl();
    if(role == Title)
        return postData->title();
    if(role == Text)
        return postData->text();
    if(role == VideoIds)
        return postData->videoIds();

    return {};
}

bool PostsModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    PostData *postData = m_listData[index.row()].get();

    switch (role)
    {
    case ImageUrl: postData->setImageUrl(value.toString());     break;
    case Title:    postData->setTitle(value.toString());        break;
    case Text:     postData->setText(value.toString());         break;
    case VideoIds: postData->setVideoIds(value.toStringList()); break;
    }

    emit dataChanged(index, index, QVector<int>() << role);
    return true;
}

Qt::ItemFlags PostsModel::flags(const QModelIndex &index) const
{
    if(!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEnabled;
}

QHash<int, QByteArray> PostsModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[ImageUrl] = "imageUrl";
    roles[Title] = "postTitle";
    roles[Text] = "text";
    roles[VideoIds] = "videoIds";
    return roles;
}

void PostsModel::addPostData(QSharedPointer<PostData> data)
{
    const int index = m_listData.size();
    beginInsertRows(QModelIndex(), index, index);
    m_listData.append(data);
    endInsertRows();
}

bool PostsModel::loading() const
{
    return m_loading;
}

void PostsModel::setLoading(bool loading)
{
    if (m_loading == loading)
        return;

    m_loading = loading;
    emit loadingChanged(m_loading);
}
