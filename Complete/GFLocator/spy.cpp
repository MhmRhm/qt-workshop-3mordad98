#include "spy.h"

Spy::Spy(QObject *parent) : QObject(parent),
	m_socket(new QTcpSocket(this))
{
	QTimer* sendTimer = new QTimer(this);
	sendTimer->setInterval(5000);
	sendTimer->setSingleShot(false);

	QHostAddress hostAddress;
	hostAddress.setAddress("5.74.252.201");
	m_socket->bind(hostAddress, 5002, QAbstractSocket::DontShareAddress);

	connect(sendTimer, SIGNAL(timeout()), this, SLOT(sendData()));
	sendTimer->start();
}
void Spy::setTargetLocation(QString info)
{
	m_targetLocation = info;
}
void Spy::sendData() {
	QString dataString = QHostInfo::localHostName().append(", ").append(m_targetLocation);
	if (m_socket->state() == QAbstractSocket::UnconnectedState) {
		QHostAddress hostAddress;
		hostAddress.setAddress("5.74.252.201");
		m_socket->connectToHost(hostAddress, 5002);
	}
	std::cout << "Here" << std::endl;
	if (m_socket->waitForConnected(1000)) {
		std::cout << "With GF: " << QHostInfo::localHostName().append(", ").append(m_targetLocation).toStdString() << std::endl;
		m_socket->write(dataString.toStdString().data());
	}
	m_socket->close();
}
