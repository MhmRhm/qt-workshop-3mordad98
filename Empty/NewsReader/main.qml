import QtQuick 2.12
import QtWebView 1.1
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.XmlListModel 2.12
import QtQuick.LocalStorage 2.12
import QtQuick.Controls.Material 2.3

ApplicationWindow {
	visible: true
	visibility: Window.Maximized
	title: qsTr("News Reader")
	Material.theme: "Light"
	Material.accent: "aqua"
	property string nyKey: "C8QRfWe41CCdyHRQWAEIXTB7LyAMVfX2"
	property string topStoriesURL: "https://api.nytimes.com/svc/topstories/v2/home.json?api-key="
	property string newsWireURL: "https://api.nytimes.com/svc/news/v3/content/all/all.json?api-key="

	Action {
	}

	header: Rectangle { //Item
		id: header
	}

	ListModel {
		id: savedArticlesModel
	}

	Drawer {
		id: drawer
	}

	ListModel {
		id: feedModel
	}

	BusyIndicator {
		id: feedFetchIndicator
		running: image.status === Image.Loading
		anchors.centerIn: parent
	}

	Rectangle {
		anchors.fill: parent
		FocusScope {
			id: webPageScope
		}

		Component {
			id: highlight
			Rectangle {
			}
		}

		Popup {
			id: popup
		}

		GridView {
			id: feedGridview
		}
	}

	Component.onCompleted: {
		feedFetchIndicator.running = true
		var xhr = new XMLHttpRequest
		xhr.open("GET", topStoriesURL + nyKey)
		xhr.onreadystatechange = function() {
		}
		xhr.send()
	}
}
