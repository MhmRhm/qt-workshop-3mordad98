#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QHBoxLayout>
#include <QVBoxLayout>
#include <QPushButton>
#include <QFuture>
#include <QThread>
#include <QtConcurrent/QtConcurrent>

#include <iostream>

#include "somefunctionobject.h"
#include "somethreadobject.h"

using namespace std;

class MainWindow : public QMainWindow
{
	Q_OBJECT

public:
	MainWindow(QWidget *parent = nullptr);
	~MainWindow();
private slots:
	void button1Operation1(bool);
	void button2Operation1(bool);

	void button1Operation2(bool);
	void button2Operation2(bool);
private:
	QPushButton* m_button1;
	QPushButton* m_button2;

	QFuture<void> m_inParallel;
	SomeFunctionObject* m_funObj;
	SomeThreadObject* m_threadObj;
};

#endif // MAINWINDOW_H
