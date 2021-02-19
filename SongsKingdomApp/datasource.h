#ifndef DATASOURCE_H
#define DATASOURCE_H

#include <QObject>

class QNetworkAccessManager;
class QNetworkReply;
class QByteArray;

class DataSource : public QObject
{
    Q_OBJECT
public:
    explicit DataSource(QObject *parent = nullptr);

    Q_INVOKABLE void fetchPage();

signals:

private slots:
    void dataReadyRead();
    void dataReadFinished();

private:
    QNetworkAccessManager *m_NetManager = nullptr;
    QNetworkReply *m_NetReply = nullptr;
    QByteArray *m_DataBuffer = nullptr;
};

#endif // DATASOURCE_H
