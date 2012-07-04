#ifndef DEVICEMANAGER_H
#define DEVICEMANAGER_H

#include <QObject>

class DeviceManager : public QObject
{
    Q_OBJECT
public:
    explicit DeviceManager(QObject *parent = 0);

    static quint32 getDeviceNO();
    static void setDeviceNO(quint32 &deviceNO);
    static QString getServerIP();
    static void setServerIP(QString &serverIP);
    static QString getDeviceMac();
    static QString getDeviceIP();
    
signals:
    void registerSignal();
    
public slots:
    static bool isRegistered();
    void registerDevice();

private:
    static quint32 mDeviceNO;
    static QString mServerIP;
};

#endif // DEVICEMANAGER_H
