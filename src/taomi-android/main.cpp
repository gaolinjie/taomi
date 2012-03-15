#include <QtGui/QApplication>
#include <QtDeclarative/QDeclarativeView>
#include <QDeclarativeContext>

#include "client.h"

int main(int argc, char *argv[])
{
    QApplication::setGraphicsSystem("raster");
    QApplication a(argc, argv);

    QDeclarativeView view;
    view.rootContext()->setContextProperty("client", new Client);
    view.setSource(QUrl("qrc:/qml/main.qml"));

    QObject::connect((QObject*)view.engine(), SIGNAL(quit()), &a, SLOT(quit()));

    view.show();

    return a.exec();
}
