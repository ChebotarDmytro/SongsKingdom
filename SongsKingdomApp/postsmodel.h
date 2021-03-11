#ifndef POSTSMODEL_H
#define POSTSMODEL_H

#include <QAbstractListModel>
#include <QSharedPointer>

class PostData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString imageUrl READ imageUrl WRITE setImageUrl NOTIFY imageUrlChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)
    Q_PROPERTY(QStringList videoIds READ videoIds WRITE setVideoIds NOTIFY videoIdsChanged)
public:
    explicit PostData(QObject *parent = nullptr);

    QString imageUrl() const;
    QString title() const;
    QString text() const;
    QStringList videoIds() const;

public slots:
    void setImageUrl(QString imageUrl);
    void setTitle(QString title);
    void setText(QString text);
    void setVideoIds(QStringList videoIds);

signals:
    void imageUrlChanged(QString imageUrl);
    void titleChanged(QString title);
    void textChanged(QString text);
    void videoIdsChanged(QStringList videoIds);

private:
    QString m_imageUrl;
    QString m_title;
    QString m_text;
    QStringList m_videoIds;
};

class PostsModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(bool loading READ loading WRITE setLoading NOTIFY loadingChanged)
public:
    enum TypeData
    {

    };
    enum HtmlRoles
    {
        ImageUrl = Qt::UserRole + 1,
        Title,
        Text,
        VideoIds,
    };

    explicit PostsModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;
    QHash<int, QByteArray> roleNames() const override;

    void addPostData(QSharedPointer<PostData> data);
    bool loading() const;

public slots:
    void setLoading(bool loading);

signals:
    void loadingChanged(bool loading);

private:
    QList<QSharedPointer<PostData>> m_listData;
    bool m_loading = true;
};

#endif // POSTSMODEL_H
