#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <run_command.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    qputenv("QML_XHR_ALLOW_FILE_READ", QByteArray("1"));

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    QString myPath;
    myPath=QCoreApplication::applicationDirPath();
    engine.setOfflineStoragePath(QString(myPath));

    engine.rootContext()->setContextProperty("runScript",new run_command);

    engine.load(url);

    return app.exec();
}
