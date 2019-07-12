#include "mainwindow.h"

void someFunction(unsigned int);

MainWindow::MainWindow(QWidget *parent)	: QMainWindow(parent),
	m_button1(new QPushButton),
	m_button2(new QPushButton)
{
	QWidget* centralWidget = new QWidget;
	QVBoxLayout* centralLayout = new QVBoxLayout(centralWidget);

	m_button1->setText("Operation 1");
	m_button2->setText("Operation 2");

	m_button1->setCheckable(true);
	m_button2->setCheckable(true);

	centralLayout->addWidget(m_button1);
	centralLayout->addWidget(m_button2);

//	connect(m_button1, &QPushButton::clicked, this, &MainWindow::button1Operation1);
//	connect(m_button2, &QPushButton::clicked, this, &MainWindow::button2Operation1);

//	m_funObj = new SomeFunctionObject(3000);
//	connect(m_button1, &QPushButton::clicked, m_funObj, &SomeFunctionObject::doSomething);
//	connect(m_button2, &QPushButton::clicked, this, &MainWindow::button2Operation2);

//	connect(m_button1, &QPushButton::clicked, m_button1, [this](){
//		m_button1->setDisabled(true);
//	});
//	connect(m_funObj, &SomeFunctionObject::operationOver, m_button1, [this](){
//		m_button1->setDisabled(false);
//	});

//	QThread* someCreatedThread = new QThread(this);
//	m_funObj->moveToThread(someCreatedThread);
//	someCreatedThread->start();

	m_threadObj = new SomeThreadObject(3000, this);
	connect(m_button1, &QPushButton::clicked, m_threadObj, [this](){
		m_threadObj->start();
	});
	connect(m_button2, &QPushButton::clicked, this, &MainWindow::button2Operation2);

	this->setCentralWidget(centralWidget);
}

void MainWindow::button1Operation1(bool state)
{
	int time = 3000;
	if (m_inParallel.isFinished()) {
		m_inParallel = QtConcurrent::run(someFunction, time);
	}
}

void MainWindow::button2Operation1(bool state)
{
	cout << "button 2  " << state << endl;
}

void MainWindow::button1Operation2(bool state)
{
}

void MainWindow::button2Operation2(bool state)
{
	cout << "button 2  " << state << endl;
}

MainWindow::~MainWindow()
{
	if (m_funObj) {
		m_funObj->deleteLater();
	}
}

void someFunction(unsigned int time)
{
	cout << "starting Operation 1" << endl;
	QThread::msleep(time);
	cout << "Finishing Operation 1" << endl;
}
