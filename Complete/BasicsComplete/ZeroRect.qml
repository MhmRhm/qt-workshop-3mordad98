import QtQuick 2.0

Item {
	anchors.fill: parent
	Rectangle {
		id: zeroRect
		width: 200
		height: 200
		color: "yellow"
	}
	Rectangle {
		id: oneRect
		x: 200
		width: 300
		height: 300
		color: "red"
	}
	Rectangle {
		id: twoRect
		x: 500
		width: 400
		height: 400
		color: "blue"
	}
}
