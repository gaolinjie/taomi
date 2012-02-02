#include <QtGui/QApplication>
#include <QtDeclarative/QDeclarativeView>
#include <QObject>
#include <QGLFormat>

int main(int argc, char *argv[])
{
    QApplication::setGraphicsSystem("raster");
    QApplication a(argc, argv);

    QDeclarativeView view;
    view.setSource(QUrl("qrc:/qml/main.qml"));

    view.showFullScreen();

    return a.exec();
}
