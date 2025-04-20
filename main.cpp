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
    GFile file;
    file.setSource("./scale.txt");
    QString s=file.read();
    qputenv("QT_SCALE_FACTOR",s.toLatin1());
    file.setSource("./run.ini");
    s=file.read();
    QUrl url(QStringLiteral("qrc:/main.qml"));
    if(s=="bar"){
        url=QStringLiteral("qrc:/main_bar.qml");
    }

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
