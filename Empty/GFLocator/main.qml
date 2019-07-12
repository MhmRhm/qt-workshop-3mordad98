import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.2
import QtQuick.Window 2.12
import QtLocation 5.12
import QtPositioning 5.12
import QtQuick.Controls.Material 2.3

Window {
	visible: true
	title: qsTr("Where is my GF?!")
	Material.theme: "Dark"
	visibility: Window.FullScreen
	color: Material.background

	readonly property FontLoader fontAwesomeSolid: FontLoader {
		source: "./Font Awesome 5 Free-Solid-900.otf"
	}

	Plugin {
		id: mapPlugin
	}
	MapQuickItem {
		id: marker
	}
	PositionSource {
		id: currentLocation
	}
	Map {
		id: map
	}

	Rectangle {
		anchors.bottom: map.bottom
		anchors.right: map.right
		anchors.left: map.left
		height: 50
		color: Material.background
		Button {
			id: controlsRect
		}
	}
}
