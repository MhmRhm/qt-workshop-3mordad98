import QtQuick 2.0

Item {
	anchors.fill: parent
	Rectangle {
		id: oneRect
		width: 400
		height: 400
		color: "sienna"
		anchors.centerIn: parent
		radius: width/3
	}
	Rectangle {
		id: magas1
		color: "black"
		width: oneRect.width/10
		height: width
		anchors.top: oneRect.bottom
		anchors.left: oneRect.right
		radius: width
	}
	Rectangle {
		id: magas2
		color: "black"
		width: oneRect.width/10
		height: width
		anchors.bottom: oneRect.top
		anchors.right: oneRect.left
		radius: width
	}
	Rectangle {
		id: textRect
		width: oneRect.width
		height: oneRect.height/10
		radius: width
		color: "aqua"
		anchors.horizontalCenter: oneRect.horizontalCenter
		anchors.top: oneRect.bottom
		anchors.right: magas1.left
		anchors.topMargin: 20
	}
}
