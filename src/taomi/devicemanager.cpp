#include "devicemanager.h"
#include <QtNetwork>

DeviceManager::DeviceManager(QObject *parent) :
    QObject(parent)
{
}

quint32 DeviceManager::mDeviceNO = 0;
QString DeviceManager::mServerIP = "";

bool DeviceManager::isRegistered()
{
    if (mDeviceNO) {
        // have registered
        return true;
    }
    else {
        // not registered
        return false;
    }
}

void DeviceManager::registerDevice()
{
    emit registerSignal();
}

quint32 DeviceManager::getDeviceNO()
{
    return mDeviceNO;
}

void DeviceManager::setDeviceNO(quint32 &deviceNO)
{
    mDeviceNO = deviceNO;
}

QString DeviceManager::getServerIP()
{
    return mServerIP;
}

void DeviceManager::setServerIP(QString &serverIP)
{
    mServerIP = serverIP;
}

QString DeviceManager::getDeviceMac()
{
    QNetworkInterface *qni;
    qni = new QNetworkInterface();
    *qni = qni->interfaceFromName(QString("%1").arg("wlan0"));
    return qni->hardwareAddress();
}

QString DeviceManager::getDeviceIP()
{
    QNetworkInterface *qni;
    qni = new QNetworkInterface();
    *qni = qni->interfaceFromName(QString("%1").arg("wlan0"));
    return qni->addressEntries().at(0).ip().toString();
}
