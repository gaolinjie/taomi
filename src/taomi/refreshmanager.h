#ifndef REFRESHMANAGER_H
#define REFRESHMANAGER_H

#include <QObject>

class RefreshManager : public QObject
{
    Q_OBJECT
public:
    explicit RefreshManager(QObject *parent = 0);
    
signals:
    
public slots:
    QString getImageNext(quint16 cid);
};

#endif // REFRESHMANAGER_H
