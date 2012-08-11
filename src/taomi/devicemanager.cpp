#include "devicemanager.h"
#include <QtNetwork>
#include <QDebug>

#define TAG "[DeviceManager]"

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
    if (mServerIP != serverIP) {
        qDebug() << "WARNNING: The server IP has changed";
    }
    mServerIP = serverIP;
}

QString DeviceManager::getDeviceMac()
{
#ifdef WIN32
    QString str2;
    QList<QNetworkInterface> list = QNetworkInterface::allInterfaces();
    str2 = list.at(1).hardwareAddress();
    return str2;
#else
    QNetworkInterface *qni;
    qni = new QNetworkInterface();
    //*qni = qni->interfaceFromName(QString("%1").arg("wlan0"));
    *qni = qni->interfaceFromName(QString("%1").arg("eth0"));
    return qni->hardwareAddress();
#endif
}

QString DeviceManager::getDeviceIP()
{   
#ifdef WIN32
    // Windows code here
    QString hostIP;
    QString localHostName = QHostInfo::localHostName();
    QHostInfo info = QHostInfo::fromName(localHostName);
    foreach(QHostAddress address,info.addresses())
    {
        if(address.protocol() == QAbstractSocket::IPv4Protocol)
        {
            hostIP = address.toString();
        }
    }
    return hostIP;
#else
    QNetworkInterface *qni;
    qni = new QNetworkInterface();
    //*qni = qni->interfaceFromName(QString("%1").arg("wlan0"));
    *qni = qni->interfaceFromName(QString("%1").arg("eth0"));

    // Begin Issue #4, gaolinjie, 2012-04-12 //
    QString ip;
    if (qni->addressEntries().isEmpty())
    {
        //qCritical() << TAG << "ERROR: Cannot find wireless network hardware" << __FILE__ << __LINE__ ;
    }
    else
    {

        ip = qni->addressEntries().at(0).ip().toString();
    }

    return ip;
    // End Issue #4 //
#endif
}
