#ifndef SOMETHREADOBJECT_H
#define SOMETHREADOBJECT_H

#include <QObject>
#include <QThread>

#include <iostream>

using namespace std;

class SomeThreadObject : public QThread
{
	Q_OBJECT
public slots:
	void run() override;
public:
	explicit SomeThreadObject(unsigned int time, QObject *parent = nullptr);
private:
	unsigned int m_time;
};

#endif // SOMETHREADOBJECT_H
