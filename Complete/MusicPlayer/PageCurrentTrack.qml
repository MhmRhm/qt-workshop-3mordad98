import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import QtMultimedia 5.12

import track 1.0

Page {
	id: pageCurrentTrack
	background: Material.background

	property var currentTrack

	signal nextIsRequested(var currentTrack)
	signal previousIsRequested(var currentTrack)

	MediaPlayer {
		id: mediaPlayer
		source: "file://" + currentTrack.path
		autoLoad: true
		onStatusChanged: {
			if (status === MediaPlayer.Loaded) {
				platPauseTrack.isPlaying = true
				play()
			}
			if (status === MediaPlayer.EndOfMedia) {
				nextIsRequested(currentTrack)
			}
		}
	}

	Rectangle {
		anchors.fill: parent
		anchors.margins: 50
		color: Material.background

		Image {
			id: trackCoverArt
			anchors.fill: parent
			fillMode: Image.PreserveAspectFit
			source: "image://coverArts/" + currentTrack.path
		}
	}

	footer: Item {
		id: footerItem
		height: tabBar.height
		RowLayout {
			anchors.fill: parent
			layoutDirection: Qt.LeftToRight
			Button {
				id: previousTrack
				Layout.fillWidth: true
				Layout.maximumWidth: parent.width/3
				font.family: fontAwesomeSolid.name
				text: "\uf048"
				flat: true
				onClicked: {
					previousIsRequested(currentTrack)
				}
			}
			Button {
				id: platPauseTrack
				Layout.fillWidth: true
				Layout.maximumWidth: parent.width/3
				font.family: fontAwesomeSolid.name
				text: isPlaying? "\uf04c" : "\uf04b"
				flat: true
				property bool isPlaying: false
				onClicked: {
					isPlaying = !isPlaying
					if (isPlaying) {
						mediaPlayer.play()
					} else {
						mediaPlayer.pause()
					}
				}
			}
			Button {
				id: nextTrack
				Layout.fillWidth: true
				Layout.maximumWidth: parent.width/3
				font.family: fontAwesomeSolid.name
				text: "\uf051"
				flat: true
				onClicked: {
					nextIsRequested(currentTrack)
				}
			}
		}
	}

	function setCurrentTrack(track) {
		currentTrack = track
	}
}
