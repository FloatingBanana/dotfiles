pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import qs.style
import qs.elements

DisplayText {
	id: root
	text: "  "

	required property ShellScreen currentScreen

	MouseArea {
		anchors.fill: parent
		onClicked: popup.show()
	}

	CustomPopup {
		id: popup
		width: 600
		height: 600
		x: screen.virtualX + (screen.width - width) / 2
		y: screen.virtualY + (screen.height - height) / 2

		ColumnLayout {
			anchors {fill: parent; margins: 10}

			CustomTextField {
				id: searchField
				placeholderText: "Search:"
				Layout.fillWidth: true
				focus: true

				onDisplayTextChanged: {
					searchProc.searchInput = this.displayText
				}

				Keys.onUpPressed: appList.decrementCurrentIndex()
				Keys.onDownPressed: appList.incrementCurrentIndex()
				Keys.onBacktabPressed: appList.decrementCurrentIndex()
				Keys.onTabPressed: appList.incrementCurrentIndex()
				Keys.onLeftPressed: categoryTabs.decrementCurrentIndex()
				Keys.onRightPressed: categoryTabs.incrementCurrentIndex()
			}

			Process {
				id: searchProc
				stdout: StdioCollector {
					onStreamFinished: {
						let filtered = text.split(/\n/)

						let apps = DesktopEntries.applications.values.filter(e => filtered.includes(e.name))

						if (categoryTabs.currentIndex > 0) {
							let categories = categoryTabs.categories[categoryTabs.currentIndex].category
							apps = apps.filter(e => e.categories.some(c => categories.includes(c)))

						}

						apps = apps.sort((a, b) => filtered.indexOf(a.name) - filtered.indexOf(b.name))
						appList.model = apps
					}
				}
				onSearchInputChanged: {
					let allEntries = DesktopEntries.applications.values.filter(e => !e.nodDisplay)
					command = [ "zsh", "-c", `fzf --filter='${searchInput}' <<< "${allEntries.map(e => e.name).join("\n")}"` ]
					running = true
				}
				Component.onCompleted: searchInputChanged()
				
				property string searchInput: ""
			}


			TabBar {
				id: categoryTabs
				spacing: 5
				focusPolicy: Qt.NoFocus
				Layout.fillWidth: true
				Layout.preferredHeight: Style.fontSize * 2
				onCurrentIndexChanged: searchProc.searchInputChanged()

				Repeater {
					model: categoryTabs.categories
					delegate: CustomTabButton {
						text: modelData.icon
						focusPolicy: Qt.NoFocus
						required property var modelData
					}
				}

				property var categories: [
					{icon: "", category: []},
					{icon: "󰺵", category: ["Game"]},
					{icon: "󱁤", category: ["System", "Utility", "Settings"]},
					{icon: "", category: ["Graphics", "Viewer"]},
					{icon: "󰖟", category: ["WebBrowser"]},
					{icon: "", category: ["Video", "AudioVideo", "Player"]},
					{icon: "", category: ["Development", "Building"]},
				]
			}

			ListView {
				id: appList
				Layout.fillWidth: true
				Layout.fillHeight: true
				spacing: 2
				clip: true
				highlightMoveDuration: 100
				keyNavigationWraps: true
				focusPolicy: Qt.NoFocus

				delegate: Rectangle {
					id: card
					color: ListView.isCurrentItem ? Style.colFg : Style.colBg
					implicitWidth: appList.width
					implicitHeight: cardLayout.implicitHeight + 20
					visible: modelData !== undefined
					radius: 10
					border {color: Style.colFg; width: 2}
					Layout.fillWidth: true

					required property DesktopEntry modelData
					required property int index

					RowLayout {
						id: cardLayout
						anchors {fill: parent; margins: 10}
						spacing: 10

						IconImage {
							source: "image://icon/" + card.modelData.icon
							implicitSize: 36
							visible: card.modelData.icon !== ""
							Layout.alignment: Qt.AlignTop
						}

						ColumnLayout {
							Layout.fillWidth: true
							spacing: 2

							Text {
								text: card.modelData.name
								color: card.ListView.isCurrentItem ? Style.colBg : Style.colFg
								font {family: Style.fontFamily; pixelSize: Style.fontSize; bold: true}
								elide: Text.ElideRight
								Layout.fillWidth: true
							}

							Text {
								text: card.modelData.comment !== "" ? card.modelData.comment : card.modelData.genericName
								color: card.ListView.isCurrentItem ? Style.colBg : Style.colFg
								font {family: Style.fontFamily; pixelSize: Style.fontSize; bold: false}
								visible: text !== ""
								wrapMode: Text.WordWrap
								Layout.fillWidth: true
							}
						}

						DisplayText {
							text: ""
							visible: modelData.actions.length > 0
							color: card.ListView.isCurrentItem ? Style.colBg : Style.colFg
							font.pixelSize: Style.fontSize
							Layout.alignment: Qt.AlignCenter

							MouseArea {
								anchors.fill: parent
								cursorShape: Qt.PointingHandCursor
								hoverEnabled: true
								acceptedButtons: Qt.RightButton
								onClicked: context.popup()
							}

							Menu {
								id: context

								Repeater {
									model: card.modelData.actions

									MenuItem {
										text: modelData.name
										onTriggered: {
											if (card.modelData.runInTerminal) {
												Quickshell.execDetached({ command: ["footclient", "zsh", "-i", "-c", modelData.execString] })
											} else {
												modelData.execute()
											}
											popup.close()
										}
										required property DesktopAction modelData
									}
								}
							}
						}
					}

					MouseArea {
						anchors.fill: parent
						hoverEnabled: true
						cursorShape: Qt.PointingHandCursor
						onEntered: appList.currentIndex = card.index
						onClicked: popup.execute(card.modelData)
					}
				}
					
				ScrollBar.vertical: ScrollBar {
					policy: ScrollBar.AsNeeded
					active: true
				}
			}
		}

		Shortcut {
			sequences: ["Enter", "Return"]
			onActivated: {
				if (appList.currentIndex >= 0) {
					popup.execute(appList.model[appList.currentIndex])
				}
			}
		}

		function execute(entry: DesktopEntry): void {
			if (entry.runInTerminal) {
				Quickshell.execDetached({ command: ["footclient", "zsh", "-i", "-c", entry.execString] })
			} else {
				entry.execute()
			}
			popup.close()
		}
	}

	GlobalShortcut {
		name: "apprunner"
		onPressed: {
			let focused = Quickshell.screens.find(s => s.name === Hyprland.focusedMonitor?.name)
			if (focused?.name === root.currentScreen.name) {
				popup.show()
				searchField.text = ""
				categoryTabs.currentIndex = 0
			}
		}
	}
}
