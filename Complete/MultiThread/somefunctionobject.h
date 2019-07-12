#ifndef SOMEFUNCTIONOBJECT_H
#define SOMEFUNCTIONOBJECT_H

#include <QObject>
#include <QThread>

#include <iostream>

using namespace std;

class SomeFunctionObject : public QObject
{
	Q_OBJECT
public:
	explicit SomeFunctionObject(unsigned int time, QObject *parent = nullptr);

signals:
	void operationOver();
public slots:
	void doSomething();
private:
	unsigned int m_time;
};

#endif // SOMEFUNCTIONOBJECT_H
