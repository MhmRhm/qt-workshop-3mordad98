#include "agent.h"

Agent::Agent(QObject *parent) : QObject(parent),
  m_server(new QTcpServer(this))
{
}
QGeoCoordinate Agent::getCurrentLocation() {
	return m_location;
}
void Agent::handelNewConnection() {
}
