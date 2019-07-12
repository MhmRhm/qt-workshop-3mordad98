import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

import track 1.0

Page {
	id: pageTracks
	background: Material.background

	signal trackClicked (var track)

	ListModel {
		id: tracksListModel
	}

	ListView {
		id: tracksListView
		anchors.fill: parent
		model: tracksListModel
		delegate: Component {
			id: trackDelegate
			Button {
				id: trackDelegateButton
				flat: true
				width: parent.width
				height: tabBar.height
				contentItem: Item {
					anchors.fill: parent
					anchors.margins: 5
					Image {
						id: trackDelegateButtonCoverArt
						height: parent.height
						width: height
						anchors.margins: 5
						horizontalAlignment: Text.AlignHCenter
						verticalAlignment: Text.AlignVCenter
						source: "image://coverArts/" + path
					}
					Text {
						id: trackDelegateButtonTitle
						height: parent.height
						anchors.left: trackDelegateButtonCoverArt.right
						anchors.leftMargin: 5
						text: title
						font: trackDelegateButton.font
						fontSizeMode: Text.HorizontalFit
						color: Material.accent
						horizontalAlignment: Text.AlignLeft
						verticalAlignment: Text.AlignVCenter
						elide: Text.ElideRight
					}
					Text {
						id: trackDelegateButtonAlbum
						anchors.left: trackDelegateButtonTitle.right
						anchors.right: parent.right
						height: parent.height
						anchors.leftMargin: 5
						anchors.rightMargin: 5
						text: album
						font: trackDelegateButton.font
						color: Material.foreground
						fontSizeMode: Text.HorizontalFit
						horizontalAlignment: Text.AlignLeft
						verticalAlignment: Text.AlignVCenter
						elide: Text.ElideRight
					}
				}
				onClicked: {
					trackClicked(tracksListModel.get(index))
				}
			}
		}
	}

	function addTrack(address) {
		var newTrack = Qt.createQmlObject('import track 1.0; Track {}', tracksListModel, "dynamicSnippet1")
		newTrack.path = address
		if (newTrack.isValid) {
			tracksListModel.append(newTrack)
		}
	}
	function sendNextTrack(track) {
		for (var counter = 0; counter < tracksListModel.count; counter++) {
			var nextTrack = tracksListModel.get(counter)
			if (nextTrack.path === track.path) {
				if (counter === tracksListModel.count - 1) {
					trackClicked(tracksListModel.get(0))
					break;
				} else {
					trackClicked(tracksListModel.get(counter+1))
					break;
				}
			}
		}
	}
	function sendPreviousTrack(track) {
		for (var counter = 0; counter < tracksListModel.count; counter++) {
			var nextTrack = tracksListModel.get(counter)
			if (nextTrack.path === track.path) {
				if (counter === 0) {
					trackClicked(tracksListModel.get(tracksListModel.count - 1))
				} else {
					trackClicked(tracksListModel.get(counter-1))
				}
			}
		}
	}
}
