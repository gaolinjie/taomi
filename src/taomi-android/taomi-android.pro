QT += core gui
QT += core gui declarative
QT += network
QT += sql

OTHER_FILES += \
    android/AndroidManifest.xml \
    android/res/drawable/icon.png \
    android/res/drawable/logo.png \
    android/res/drawable-hdpi/icon.png \
    android/res/drawable-ldpi/icon.png \
    android/res/drawable-mdpi/icon.png \
    android/res/layout/splash.xml \
    android/res/values/libs.xml \
    android/res/values/strings.xml \
    android/res/values-de/strings.xml \
    android/res/values-el/strings.xml \
    android/res/values-es/strings.xml \
    android/res/values-et/strings.xml \
    android/res/values-fa/strings.xml \
    android/res/values-fr/strings.xml \
    android/res/values-id/strings.xml \
    android/res/values-it/strings.xml \
    android/res/values-ja/strings.xml \
    android/res/values-ms/strings.xml \
    android/res/values-nb/strings.xml \
    android/res/values-nl/strings.xml \
    android/res/values-pl/strings.xml \
    android/res/values-pt-rBR/strings.xml \
    android/res/values-ro/strings.xml \
    android/res/values-rs/strings.xml \
    android/res/values-ru/strings.xml \
    android/res/values-zh-rCN/strings.xml \
    android/res/values-zh-rTW/strings.xml \
    android/src/org/kde/necessitas/ministro/IMinistro.aidl \
    android/src/org/kde/necessitas/ministro/IMinistroCallback.aidl \
    android/src/org/kde/necessitas/origo/QtActivity.java \
    android/src/org/kde/necessitas/origo/QtApplication.java \
    android/version.xml \
    images/wether.png \
    images/video.png \
    images/tasks.png \
    images/store.png \
    images/skaner.png \
    images/shadow.png \
    images/sett-big.png \
    images/search.png \
    images/rss.png \
    images/POI.png \
    images/note.png \
    images/minus.png \
    images/help.png \
    images/favs.png \
    images/control-panel.png \
    images/close.png \
    images/background.png \
    images/back.png \
    images/appbar.new.rest.png \
    images/appbar.minus.rest.png \
    images/appbar.close.rest.png \
    images/add.png \
    js/global.js \
    qml/UnsentView.qml \
    qml/StartModel.qml \
    qml/StartDelegate.qml \
    qml/start.qml \
    qml/ShopcarView.qml \
    qml/ShopcarList.qml \
    qml/SentView.qml \
    qml/SeatView.qml \
    qml/SeatGrid.qml \
    qml/SeatCategory.qml \
    qml/ScrollBar.qml \
    qml/rect.qml \
    qml/main.qml \
    qml/ItemsView.qml \
    qml/ItemsModel.qml \
    qml/ItemsDelegate.qml \
    qml/ImageRect.qml \
    qml/IconRect.qml \
    qml/Dialog.qml \
    qml/AlertDialog.qml

HEADERS += \
    server.h \
    refreshmanager.h \
    ordermanager.h \
    devicemanager.h \
    clientsocket.h \
    client.h

SOURCES += \
    server.cpp \
    refreshmanager.cpp \
    ordermanager.cpp \
    main.cpp \
    devicemanager.cpp \
    clientsocket.cpp \
    client.cpp

RESOURCES += \
    resource.qrc







