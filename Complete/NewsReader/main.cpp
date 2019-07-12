#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <qtwebengineglobal.h>
#include <QFontDatabase>
#include <QQuickStyle>
#include <QIcon>

int main(int argc, char *argv[])
{
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
	QGuiApplication app(argc, argv);
	QQmlApplicationEngine engine;

	QtWebEngine::initialize();
	engine.setOfflineStoragePath("/home/mohammad");
	app.setWindowIcon(QIcon(QStringLiteral(":AppLogoColor.png")));
	QFontDatabase::addApplicationFont(":/fonts/Font Awesome 5 Free-Solid-900.otf");

	const QUrl url(QStringLiteral("qrc:/main.qml"));
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
					 &app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);
	engine.load(url);

	return app.exec();
}
