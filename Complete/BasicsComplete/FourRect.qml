import QtQuick 2.0

Item {
	anchors.fill: parent
	Rectangle {
		id: rect1
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.right: parent.horizontalCenter
		anchors.bottom: parent.verticalCenter
		color: "aqua"
		Loader {
			anchors.fill: parent
			sourceComponent: firstComp
		}
	}
	Rectangle {
		id: rect2
		anchors.top: parent.top
		anchors.left: parent.horizontalCenter
		anchors.right: parent.right
		anchors.bottom: parent.verticalCenter
		color: "aquamarine"
		Loader {
			anchors.fill: parent
			sourceComponent: secondComp
		}
	}
	Rectangle {
		id: rect3
		anchors.top: parent.verticalCenter
		anchors.left: parent.left
		anchors.right: parent.horizontalCenter
		anchors.bottom: parent.bottom
		color: "yellow"
		Loader {
			anchors.fill: parent
			sourceComponent: thirdComp
		}
	}
	Rectangle {
		id: rect4
		anchors.top: parent.verticalCenter
		anchors.left: parent.horizontalCenter
		anchors.right: parent.right
		anchors.bottom: parent.bottom
		color: "pink"
		Loader {
			anchors.fill: parent
			sourceComponent: fourthComp
		}
	}

	Component {
		id: firstComp
		Column {
			spacing: 10
			Rectangle {
				height: 100
				width: parent.width
				color: "black"
			}
			Rectangle {
				height: 100
				width: parent.width
				color: "black"
			}
		}
	}
	Component {
		id: secondComp
		Row {
			anchors.fill: parent
			anchors.margins: 10
			spacing: 10
			Rectangle {
				width: 100
				height: parent.height
				color: "black"
			}
			Rectangle {
				width: 100
				height: parent.height
				color: "black"
			}
		}
	}
	Component {
		id: thirdComp
		Grid {
			anchors.fill: parent
			anchors.margins: 10
			spacing: 10
			Rectangle {
				width: 100
				height: width
				color: "black"
			}
			Rectangle {
				width: 100
				height: width
				color: "black"
			}
		}
	}
	Component {
		id: fourthComp
		Flow {
			anchors.fill: parent
			anchors.margins: 10
			spacing: 10
			Rectangle {
				width: 100
				height: width
				color: "black"
			}
			Rectangle {
				width: 100
				height: width
				color: "black"
			}
		}
	}
}
