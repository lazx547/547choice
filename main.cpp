#include "gfile.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <gfile.h>
#include "delbuttontype.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterUncreatableMetaObject(DelButtonType::staticMetaObject, "DelegateUI.Controls", 1, 0
                                     , "DelButtonType", "Access to enums & flags only");

    qmlRegisterType<GFile>("GFile",1,2,"GFile");
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
