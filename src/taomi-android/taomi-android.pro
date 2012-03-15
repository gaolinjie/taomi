QT += core gui
QT += core gui declarative
QT += network

OTHER_FILES += \
    android/src/org/kde/necessitas/origo/QtApplication.java \
    android/src/org/kde/necessitas/origo/QtActivity.java \
    android/src/org/kde/necessitas/ministro/IMinistro.aidl \
    android/src/org/kde/necessitas/ministro/IMinistroCallback.aidl \
    android/AndroidManifest.xml \
    android/res/values/strings.xml \
    android/res/values/libs.xml \
    android/res/values-nb/strings.xml \
    android/res/values-rs/strings.xml \
    android/res/values-et/strings.xml \
    android/res/values-it/strings.xml \
    android/res/drawable-mdpi/icon.png \
    android/res/values-fa/strings.xml \
    android/res/values-zh-rCN/strings.xml \
    android/res/values-nl/strings.xml \
    android/res/layout/splash.xml \
    android/res/drawable/icon.png \
    android/res/drawable/logo.png \
    android/res/values-es/strings.xml \
    android/res/values-de/strings.xml \
    android/res/values-pl/strings.xml \
    android/res/drawable-ldpi/icon.png \
    android/res/values-ms/strings.xml \
    android/res/values-ja/strings.xml \
    android/res/values-pt-rBR/strings.xml \
    android/res/drawable-hdpi/icon.png \
    android/res/values-el/strings.xml \
    android/res/values-ro/strings.xml \
    android/res/values-id/strings.xml \
    android/res/values-fr/strings.xml \
    android/res/values-ru/strings.xml \
    android/res/values-zh-rTW/strings.xml \
    android/version.xml \
    qml/DetailView.qml \
    qml/IconRect.qml \
    qml/ImageRect.qml \
    qml/ItemsDelegate.qml \
    qml/ItemsModel.qml \
    qml/ItemsView.qml \
    qml/ItemsView2.qml \
    qml/main.qml \
    qml/rect.qml \
    qml/ScrollBar.qml \
    qml/ShopcarListDelegate.qml \
    qml/ShopcarModel.qml \
    qml/ShopcarView.qml \
    qml/ShopcarViewDelegate.qml \
    qml/start.qml \
    qml/StartDelegate.qml \
    qml/StartModel.qml \
    js/global.js \
    images/add.png \
    images/appbar.close.rest.png \
    images/appbar.minus.rest.png \
    images/appbar.new.rest.png \
    images/baba-ganoush.jpg \
    images/back.png \
    images/background.png \
    images/BimBimBop.jpg \
    images/Blueberry_muffins.jpg \
    images/Carrot-Ginger-Soup.jpg \
    images/CheeseStraws.jpg \
    images/Cherries.jpg \
    images/close.png \
    images/control-panel.png \
    images/favs.png \
    images/help.png \
    images/Kermit-Lynch-Wine.jpg \
    images/minus.png \
    images/note.png \
    images/POI.png \
    images/rss.png \
    images/rustic_soup.jpg \
    images/Salmon_with_pesto.jpg \
    images/SeaFoodStew.jpg \
    images/search.png \
    images/sett-big.png \
    images/shadow.png \
    images/skaner.png \
    images/Soft_Scamble_Breakfast.jpg \
    images/store.png \
    images/Summer_Salad.jpg \
    images/Tagine.jpg \
    images/Tagine_Recipe.jpg \
    images/tasks.png \
    images/Tomato-Basil-Lasagne.jpg \
    images/veggie_box.jpg \
    images/video.png \
    images/wether.png

HEADERS += \
    client.h \
    ordermanager.h

SOURCES += \
    client.cpp \
    main.cpp \
    ordermanager.cpp

RESOURCES += \
    resource.qrc







