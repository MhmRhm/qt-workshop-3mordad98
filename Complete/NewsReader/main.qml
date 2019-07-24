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
	readonly property FontLoader fontAwesomeSolid: FontLoader {
		source: "./Font Awesome 5 Free-Solid-900.otf"
	}

	Action {
		shortcut: StandardKey.Cancel
		onTriggered: {
			webPage.stop()
			webPage.visible = false
			feedGridview.focus = true
		}
	}

	header: Rectangle { //Item
		id: header
		width: parent.width
		height: 50
		color: Material.background
		Row {
			anchors.fill: parent
			spacing: 5
			Button {
				id: menuButton
				height: 48
				width: 60
				font.family: fontAwesomeSolid.name
				text: "\uf0c9"
				background: Rectangle {
					anchors.fill: parent
					color: Material.accent
					radius: 5
				}
				onClicked: {
					drawer.open()
				}
			}
			ProgressBar {
				id: progressBar
				height: menuButton.height
				width: parent.width - 2*menuButton.width - 10
				from: 0
				to: 100
				value: webPage.loadProgress
				background: Item {
					anchors.fill: parent
					Rectangle {
						anchors.fill: parent
						color: Material.background
						radius: 3
					}
				}
				contentItem: Item {
					anchors.fill: parent
					Rectangle {
						width: progressBar.visualPosition * parent.width
						height: parent.height
						radius: 3
						opacity: 0.5
						color: progressBar.value === 100 ? Material.background : Material.accent
					}
					Text {
						anchors.fill: parent
						anchors.margins: 5
						text: webPage.url
						color: Material.foreground
						font.pixelSize: 30
						fontSizeMode: Text.Fit
						horizontalAlignment: Text.AlignLeft
						verticalAlignment: Text.AlignVCenter
					}
				}
			}
			Button {
				id: exitButton
				height: 48
				width: 60
				font.family: fontAwesomeSolid.name
				text: "\uf00d"
				background: Rectangle {
					anchors.fill: parent
					color: Material.accent
					radius: 5
				}
				onClicked: {
					webPage.stop()
					webPage.visible = false
					feedGridview.focus = true
				}
			}
		}
	}

	ListModel {
		id: savedArticlesModel
	}

	Drawer {
		id: drawer
		width: 0.3 * parent.width
		height: parent.height

		ListView {
			anchors.fill: parent
			model: savedArticlesModel
			delegate: Item {
				width: drawer.width
				height: 200
				Rectangle {
					anchors.fill: parent
					color: "transparent"
					Row {
						anchors.fill: parent
						anchors.margins: 5
						spacing: 10
						Image {
							height: parent.height
							width: 200
							source: multimedia
						}
						Column {
							height: parent.height
							width: 300
							Text {
								text: title
								width: parent.width
								elide: Text.ElideRight
								fontSizeMode: Text.Fit
								font.bold: true
								wrapMode: Text.Wrap
							}
							Text {
								text: abstrct
								width: parent.width
								elide: Text.ElideRight
								fontSizeMode: Text.Fit
								wrapMode: Text.Wrap
							}
						}
					}
					MouseArea {
						anchors.fill: parent
						onClicked: {
							webPage.url = url
							webPage.visible = true
							webPageScope.focus = true
						}
					}
				}
			}
		}
		Component.onCompleted: {
		}
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
			anchors.fill: parent
			//			focus: true
			z: 100
			WebView {
				id: webPage
				anchors.fill: parent
				visible: false
			}
			Keys.onEscapePressed: {
				if (event.key === Qt.Key_Escape) {
					webPage.stop()
					webPage.visible = false
					feedGridview.focus = true
				}
			}
		}

		Component {
			id: highlight
			Rectangle {
				width: feedGridview.cellWidth; height: feedGridview.cellHeight
				color: Material.accent
				radius: 5
				opacity: 0.3
				x: feedGridview.currentItem.x
				y: feedGridview.currentItem.y
				Behavior on x { SpringAnimation { spring: 3; damping: 0.2 } }
				Behavior on y { SpringAnimation { spring: 3; damping: 0.2 } }
			}
		}
		Popup {
			id: popup
			background: Rectangle {
				anchors.fill: parent
				color: Material.background
				radius: 5
			}
			ColumnLayout {
				anchors.fill: parent
				Button {
					//					width: popup.contentWidth
					text: "Open"
					onClicked: {
						webPage.visible = true
						webPage.url = feedModel.get(feedGridview.currentIndex).url
						webPageScope.focus = true
						popup.close()
					}
				}
				Button {
					//					width: popup.contentWidth
					text: "Save"
					onClicked: {
						var db = LocalStorage.openDatabaseSync("SavedArticles", "1.0", "Saved Articles from NYTimes.", 1000000)
						db.transaction(
									function(tx) {
										var article = feedModel.get(feedGridview.currentIndex)
										tx.executeSql('CREATE TABLE IF NOT EXISTS Articles(json TEXT)')
										var rs = tx.executeSql('SELECT * FROM Articles')
										for (var i = 0; i < rs.rows.length; i++) {
											var currentArticle = JSON.parse(rs.rows.item(i).json)
											if (currentArticle.title === article.title) {
												popup.close()
												return
											}
										}
										tx.executeSql('INSERT INTO Articles VALUES(?)', [JSON.stringify(article)])
										savedArticlesModel.append(article)
										popup.close()
									}
									)
					}
				}
			}
		}

		GridView {
			id: feedGridview
			model: feedModel
			anchors.fill: parent
			cellHeight: 200
			cellWidth: 550
			focus: true
			highlight: highlight
			keyNavigationEnabled: true
			keyNavigationWraps: true
			delegate: Item {
				height: feedGridview.cellHeight
				width: feedGridview.cellWidth
				Rectangle {
					anchors.fill: parent
					color: "transparent"
					Row {
						anchors.fill: parent
						anchors.margins: 5
						spacing: 10
						Image {
							height: parent.height
							width: 200
							source: multimedia
						}
						Column {
							height: parent.height
							width: 300
							Text {
								text: title
								width: parent.width
								elide: Text.ElideRight
								fontSizeMode: Text.Fit
								font.bold: true
								wrapMode: Text.Wrap
							}
							Text {
								text: abstrct
								width: parent.width
								elide: Text.ElideRight
								fontSizeMode: Text.Fit
								wrapMode: Text.Wrap
							}
						}
					}
					MouseArea {
						anchors.fill: parent
						acceptedButtons: Qt.LeftButton | Qt.RightButton
						onClicked: {
							if (mouse.button === Qt.LeftButton) {
								feedGridview.currentIndex = index
								webPage.url = url
								webPage.visible = true
								webPageScope.focus = true
							}
							if (mouse.button === Qt.RightButton) {
								feedGridview.currentIndex = index
								popup.x = feedGridview.currentItem.x + mouse.x
								popup.y = feedGridview.currentItem.y + mouse.y
								popup.open()
							}
						}
					}
				}
				Keys.onReturnPressed: {
					webPage.visible = true
					webPage.url = url
					webPageScope.focus = true
				}
			}
		}
	}

	Component.onCompleted: {
		feedFetchIndicator.running = true
		var xhr = new XMLHttpRequest
		//xhr.open("GET", topStoriesURL + nyKey)
		xhr.open("GET", "File:///home/mohammad/Documents/QtProjects/NewsReader/news.txt")
		xhr.onreadystatechange = function() {
			if (xhr.readyState === XMLHttpRequest.DONE) {
				var data = JSON.parse(xhr.responseText)
				//				console.log(data.results)
				feedModel.clear()
				var list = data.results
				for (var i in list) {
					var multimedia = data.results[i].multimedia
					var multimediaUrl = ""
					if (multimedia[3] !== undefined) {
						multimediaUrl = multimedia[3].url
					}
					feedModel.append({
										 section: list[i].section,
										 title: list[i].title,
										 abstrct: list[i].abstract,
										 url: list[i].url,
										 byline: list[i].byline,
										 multimedia: multimediaUrl
									 })
				}
				feedFetchIndicator.running = false
				feedFetchIndicator.visible = false
			}
		}
		xhr.send()

		var db = LocalStorage.openDatabaseSync("SavedArticles", "1.0", "Saved Articles from NYTimes.", 1000000)
		db.transaction(
					function(tx) {
						tx.executeSql('CREATE TABLE IF NOT EXISTS Articles(json TEXT)')
						var rs = tx.executeSql('SELECT * FROM Articles')
						for (var i = 0; i < rs.rows.length; i++) {
							var currentArticle = JSON.parse(rs.rows.item(i).json)
							var multimedia = currentArticle.multimedia
							savedArticlesModel.append({
														  section: currentArticle.section,
														  title: currentArticle.title,
														  abstrct: currentArticle.abstrct,
														  url: currentArticle.url,
														  byline: currentArticle.byline,
														  multimedia: multimedia
													  })
						}
					}
					)
	}
}
