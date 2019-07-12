import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.3

ApplicationWindow {
	visible: true
	visibility: Window.FullScreen
	title: qsTr("Power Play")
	background: Material.background

	readonly property FontLoader fontAwesomeSolid: FontLoader {
		source: "./Font Awesome 5 Free-Solid-900.otf"
	}

	SwipeView {
		id: swipeView
		anchors.fill: parent
		currentIndex: tabBar.currentIndex
		background: Material.background

		PageTracks {
			id: pageTracks
			onTrackClicked: {
				pageCurrentTrack.setCurrentTrack(track)
			}
		}

		PageCurrentTrack {
			id: pageCurrentTrack
			onNextIsRequested: {
				pageTracks.sendNextTrack(currentTrack)
			}
			onPreviousIsRequested: {
				pageTracks.sendPreviousTrack(currentTrack)
			}
		}

		PageFiles {
			id: pageFiles
			onAddTrack: {
				pageTracks.addTrack(address)
			}
		}
	}

	footer: TabBar {
		id: tabBar
		currentIndex: swipeView.currentIndex

		TabButton {
			id: pageTracksButton
			font.family: fontAwesomeSolid.name
			text: "\uf0ca"
		}

		TabButton {
			id: pageCurrentTrackButton
			font.family: fontAwesomeSolid.name
			text: "\uf001"
		}

		TabButton {
			id: pageFilesButton
			font.family: fontAwesomeSolid.name
			text: "\uf07c"
		}
	}
}
