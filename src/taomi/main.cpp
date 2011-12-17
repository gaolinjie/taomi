#include <QtGui/QApplication>
#include <QtDeclarative/QDeclarativeView>
#include <QObject>

int main(int argc, char *argv[])
{
    QApplication::setGraphicsSystem("raster");
    QApplication a(argc, argv);

    QDeclarativeView view;
    view.setSource(QUrl("qrc:/qml/main.qml"));

    view.show();

    return a.exec();
}
