#include "agent.h"

Agent::Agent(QObject *parent) : QObject(parent),
  m_server(new QTcpServer(this))
{
	QHostAddress hostAddress;
	hostAddress.setAddress("0.0.0.0");
	m_server->listen(hostAddress, 8000);
	m_server->setMaxPendingConnections(1);

	connect(m_server, SIGNAL(newConnection()), this, SLOT(handelNewConnection()));
}
QGeoCoordinate Agent::getCurrentLocation() {
	return m_location;
}
void Agent::handelNewConnection() {
	QTcpSocket* socket = m_server->nextPendingConnection();
	if (socket->waitForReadyRead(1000)) {
		QByteArray dataArray = socket->readAll();
		QString dataString = QString(dataArray);
		std::cout << "With BF: " << dataString.toStdString() << std::endl;
		QStringList splitData = dataString.split(",");
		m_location = QGeoCoordinate(splitData.at(1).toDouble(), splitData.at(2).toDouble());
		emit currentLocationChanged(m_location);
	}
	socket->close();
	socket->deleteLater();
}
