#ifndef HTMLMODEL_H
#define HTMLMODEL_H

#include <QAbstractListModel>
#include <QSharedPointer>

class HtmlData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString pageUrl READ pageUrl WRITE setPageUrl NOTIFY pageUrlChanged)
    Q_PROPERTY(QString imageUrl READ imageUrl WRITE setImageUrl NOTIFY imageUrlChanged)
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged)
    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)
public:
    explicit HtmlData(QObject *parent = nullptr);

    QString pageUrl() const;
    QString imageUrl() const;
    QString title() const;
    QString text() const;

public slots:
    void setPageUrl(QString pageUrl);
    void setImageUrl(QString imageUrl);
    void setTitle(QString title);
    void setText(QString text);

signals:
    void pageUrlChanged(QString pageUrl);
    void imageUrlChanged(QString imageUrl);
    void titleChanged(QString title);
    void textChanged(QString text);

private:
    QString m_pageUrl;
    QString m_imageUrl;
    QString m_title;
    QString m_text;
};

class HtmlModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(bool loading READ loading WRITE setLoading NOTIFY loadingChanged)
public:
    enum HtmlRoles
    {
        PageUrl = Qt::UserRole + 1,
        ImageUrl,
        Title,
        Text
    };

    explicit HtmlModel(QObject *parent = nullptr);

    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    bool setData(const QModelIndex &index, const QVariant &value, int role = Qt::EditRole) override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;
    QHash<int, QByteArray> roleNames() const override;

    void addHtmlData(QSharedPointer<HtmlData> data);
    bool loading() const;

public slots:
    void setLoading(bool loading);

signals:
    void loadingChanged(bool loading);

private:
    QList<QSharedPointer<HtmlData>> m_listData;
    bool m_loading = true;
};

#endif // HTMLMODEL_H
