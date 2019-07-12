import QtQuick 2.12
import QtQuick.Window 2.12

Window {
	visible: true
//	width: 640
//	height: 480
	visibility: Window.Maximized
	title: qsTr("Basics")

//	ZeroRect {
//		anchors.fill: parent
//	}

//	OneRect {
//		anchors.fill: parent
//	}

	FourRect {
		anchors.fill: parent
	}
}
