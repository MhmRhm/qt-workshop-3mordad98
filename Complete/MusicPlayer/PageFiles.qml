import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import Qt.labs.folderlistmodel 2.12

Page {
	id: pageFiles
	background: Material.background

	signal addTrack (string address)

	footer: Item {
		id: footerItem
		height: tabBar.height
		RowLayout {
			anchors.fill: parent
			layoutDirection: Qt.RightToLeft
			Button {
				id: goToParenFolder
				Layout.fillWidth: true
				Layout.maximumWidth: parent.width/3
				font.family: fontAwesomeSolid.name
				text: "\uf060"
				flat: true
				onClicked: {
					if (folderModel.parentFolder != "file:///") {
						folderModel.folder = folderModel.parentFolder
					}
				}
			}
			Button {
				id: goToHomeFolder
				Layout.fillWidth: true
				Layout.maximumWidth: parent.width/3
				font.family: fontAwesomeSolid.name
				text: "\uf015"
				flat: true
				onClicked: {
					folderModel.folder = "file:///sdcard/"
				}
			}
			Button {
				id: chooseFolderButton
				Layout.fillWidth: true
				Layout.maximumWidth: parent.width/3
				font.family: fontAwesomeSolid.name
				text: "\uf00c"
				flat: true
				onClicked: {
					for (var counter = 0; counter < folderModel.count; counter++) {
						if (!folderModel.get(counter, "fileIsDir")) {
							addTrack(folderModel.get(counter, "fileURL"))
						}
					}
					notify("Folder Added")
				}
			}
		}
	}

	Rectangle {
		anchors.fill: parent
		anchors.margins: 10
		color: Material.background

		ListView {
			anchors.fill: parent
			FolderListModel {
				id: folderModel
				nameFilters: [ "*.mp3" ]
				folder: "file:///sdcard/"
			}
			Component {
				id: fileDelegate
				Button {
					id: fileDelegateButton
					text: fileName
					flat: true
					width: parent.width
					height: tabBar.height
					contentItem: Item {
						anchors.fill: parent
						Row {
							anchors.fill: parent
							spacing: 5
							Text {
								id: fileDelegateButtonIcon
								height: parent.height
								font.family: fontAwesomeSolid.name
								text: fileIsDir? "\uf07b" : "\uf15b";
								color: Material.accent
								horizontalAlignment: Text.AlignHCenter
								verticalAlignment: Text.AlignVCenter
								elide: Text.ElideRight
							}
							Text {
								id: fileDelegateButtonText
								height: parent.height
								text: fileDelegateButton.text
								font: fileDelegateButton.font
								color: Material.foreground
								horizontalAlignment: Text.AlignHCenter
								verticalAlignment: Text.AlignVCenter
								elide: Text.ElideRight
							}
						}
					}
					onClicked: {
						if (fileIsDir) {
							folderModel.folder = fileURL
						}
						else {
							addTrack(fileURL)
							notify("File Added")
						}
					}
				}
			}
			model: folderModel
			delegate: fileDelegate
		}
	}

	Rectangle {
		id: notificationRect
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.bottom: parent.bottom
		anchors.margins: 50
		height: 50
		radius: height
		color: Material.accent
		visible: false

		Text {
			id: notificationText
			anchors.fill: parent
			horizontalAlignment: Text.AlignHCenter
			verticalAlignment: Text.AlignVCenter
			color: Material.foreground
			text: ""
		}

		Timer {
			id: notificationTimer
			interval: 1000
			repeat: false
			onTriggered: {
				notificationRect.visible = false
			}
		}
	}

	function notify(message) {
		notificationText.text = message
		notificationRect.visible = true
		notificationTimer.start()
	}
}
