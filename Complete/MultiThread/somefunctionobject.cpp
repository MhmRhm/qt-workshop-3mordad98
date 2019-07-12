#include "somefunctionobject.h"

SomeFunctionObject::SomeFunctionObject(unsigned int time, QObject *parent) : QObject(parent),
	m_time(time)
{

}
void SomeFunctionObject::doSomething()
{
	cout << "starting Operation 2" << endl;
	QThread::msleep(m_time);
	cout << "Finishing Operation 2" << endl;
	emit operationOver();
}
