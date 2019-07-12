#include "somethreadobject.h"

SomeThreadObject::SomeThreadObject(unsigned int time, QObject *parent) : QThread(parent),
	m_time(time)
{

}
void SomeThreadObject::run()
{
	cout << "starting Operation 2" << endl;
	QThread::msleep(m_time);
	cout << "Finishing Operation 2" << endl;
}
