#include "htmlmodel.h"

// HtmlData

HtmlData::HtmlData(QObject *parent) : QObject(parent)
{

}

QString HtmlData::pageUrl() const
{
    return m_pageUrl;
}

QString HtmlData::imageUrl() const
{
    return m_imageUrl;
}

QString HtmlData::title() const
{
    return m_title;
}

QString HtmlData::text() const
{
    return m_text;
}

void HtmlData::setPageUrl(QString pageUrl)
{
    if (m_pageUrl == pageUrl)
        return;

    m_pageUrl = pageUrl;
    emit pageUrlChanged(m_pageUrl);
}

void HtmlData::setImageUrl(QString imageUrl)
{
    if (m_imageUrl == imageUrl)
        return;

    m_imageUrl = imageUrl;
    emit imageUrlChanged(m_imageUrl);
}

void HtmlData::setTitle(QString title)
{
    if (m_title == title)
        return;

    m_title = title;
    emit titleChanged(m_title);
}

void HtmlData::setText(QString text)
{
    if (m_text == text)
        return;

    m_text = text;
    emit textChanged(m_text);
}

// HtmlModel

HtmlModel::HtmlModel(QObject *parent) : QAbstractListModel(parent)
{

}

int HtmlModel::rowCount(const QModelIndex &parent) const
{
    return m_listData.size();
}

QVariant HtmlModel::data(const QModelIndex &index, int role) const
{
    if(!index.isValid())
        return {};
    if(index.row() < 0 || index.row() >= m_listData.count())
        return {};

    HtmlData *htmlData = m_listData[index.row()].get();
    if(role == PageUrl)
        return htmlData->pageUrl();
    if(role == ImageUrl)
        return htmlData->imageUrl();
    if(role == Title)
        return htmlData->title();
    if(role == Text)
        return htmlData->text();

    return {};
}

bool HtmlModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    HtmlData *htmlData = m_listData[index.row()].get();

    switch (role)
    {
    case PageUrl:  htmlData->setPageUrl(value.toString());  break;
    case ImageUrl: htmlData->setImageUrl(value.toString()); break;
    case Title:    htmlData->setTitle(value.toString());    break;
    case Text:     htmlData->setText(value.toString());     break;
    }

    emit dataChanged(index, index, QVector<int>() << role);
    return true;
}

Qt::ItemFlags HtmlModel::flags(const QModelIndex &index) const
{
    if(!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEnabled;
}

QHash<int, QByteArray> HtmlModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[PageUrl] = "pageUrl";
    roles[ImageUrl] = "imageUrl";
    roles[Title] = "title";
    roles[Text] = "text";
    return roles;
}

void HtmlModel::addHtmlData(QSharedPointer<HtmlData> data)
{
    const int index = m_listData.size();
    beginInsertRows(QModelIndex(), index, index);
    m_listData.append(data);
    endInsertRows();
}
