#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>

#include "track.h"
#include "imageprovider.h"

int main(int argc, char *argv[])
{
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	QGuiApplication app(argc, argv);
	QQmlApplicationEngine engine;

	QFontDatabase::addApplicationFont(":/fonts/Font Awesome 5 Free-Solid-900.otf");
	qmlRegisterType<Track>("track", 1, 0, "Track");

	ImageProvider *imageProvider = new ImageProvider;
	engine.addImageProvider("coverArts", imageProvider);

	const QUrl url(QStringLiteral("qrc:/main.qml"));
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
					 &app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);
	engine.load(url);

	return app.exec();
}
