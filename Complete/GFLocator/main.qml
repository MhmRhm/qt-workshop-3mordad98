import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.2
import QtQuick.Window 2.12
import QtLocation 5.12
import QtPositioning 5.12
import QtQuick.Controls.Material 2.3

import spy 1.0

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
		preferred: ["osm"]
		PluginParameter { name: "osm.mapping.highdpi_tiles"; value: "true" }
	}
	MapQuickItem {
		id: marker
		anchorPoint.x: 15
		anchorPoint.y: 0
		coordinate: currentLocation.position.coordinate
		sourceItem: Text {
			id: markerText
			height: 30
			width: 30
			font.pointSize: 30
			fontSizeMode: Text.Fit
			font.family: fontAwesomeSolid.name
			text: "\uf124"
			rotation: -45
			color: Material.accent
		}
	}
	Spy {
		id: spy
	}
	PositionSource {
		id: currentLocation
		updateInterval: 1000
		active: true
		onPositionChanged: {
			spy.targetLocation = "" + position.coordinate.latitude + ", " + position.coordinate.longitude
		}
	}
	Map {
		id: map
		anchors.fill: parent
		plugin: mapPlugin
		zoomLevel: 14
		center: currentLocation.position.coordinate
		bearing: isNaN(currentLocation.position.direction)? 0 : Math.floor(currentLocation.position.direction)
		tilt: 40
		copyrightsVisible: false
		Component.onCompleted: {
			addMapItem(marker)
		}
	}

	Rectangle {
		anchors.bottom: map.bottom
		anchors.right: map.right
		anchors.left: map.left
		height: 50
		color: Material.background
		Button {
			id: controlsRect
			anchors.fill: parent
			flat: true
			contentItem: Text {
				anchors.fill: parent
				anchors.margins: 10
				font.pointSize: 30
				fontSizeMode: Text.Fit
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter
				color: Material.foreground
				text: "" + currentLocation.position.coordinate.longitude + "   " + currentLocation.position.coordinate.latitude
			}
			onClicked: {
				map.center = currentLocation.position.coordinate
				map.bearing = isNaN(currentLocation.position.direction)? 0 : Math.floor(currentLocation.position.direction)
			}
		}
	}
}
