#ifndef AGENT_H
#define AGENT_H

#include <QObject>
#include <QTcpServer>
#include <QTcpSocket>
#include <QGeoCoordinate>
#include <QStringList>
#include <iostream>

class Agent : public QObject
{
	Q_OBJECT
	Q_PROPERTY(QGeoCoordinate currentLocation READ getCurrentLocation NOTIFY currentLocationChanged)
public:
	explicit Agent(QObject *parent = nullptr);

signals:
	void currentLocationChanged(QGeoCoordinate);

private slots:
	void handelNewConnection();

private:
	QGeoCoordinate getCurrentLocation();

private:
	QTcpServer* m_server;
	QGeoCoordinate m_location;
};

#endif // AGENT_H
