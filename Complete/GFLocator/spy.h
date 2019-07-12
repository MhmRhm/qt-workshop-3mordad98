#ifndef SPY_H
#define SPY_H

#include <QObject>
#include <QTimer>
#include <iostream>
#include <QHostInfo>
#include <QTcpSocket>
#include <QAbstractSocket>

class Spy : public QObject
{
	Q_OBJECT
	Q_PROPERTY(QString targetLocation WRITE setTargetLocation)

public:
	explicit Spy(QObject *parent = nullptr);

private slots:
	void sendData();

private:
	void setTargetLocation(QString);

private:
	QString m_targetLocation;
	QTcpSocket* m_socket;
};

#endif // SPY_H
