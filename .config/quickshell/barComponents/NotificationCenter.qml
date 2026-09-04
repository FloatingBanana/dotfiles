import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.style
import qs.elements

DisplayText {
	id: root
	text: history.count > 0 ? "󱅫" : "󰂚"

	required property ListModel history

	MouseArea {
		anchors.fill: parent
		onClicked: popup.show()
	}

	CustomPopup {
		id: popup
		onVisibleChanged: positionUnderItem(root)
		width: centerLayout.width + 20
		height: centerLayout.childrenRect.height + 20

		ColumnLayout {
			id: centerLayout
			width: 350
			anchors.centerIn: parent

			RowLayout {
				Text {
					text: `Notifications (${root.history.count})`
					color: Style.colFg
					font {family: Style.fontFamily; pixelSize: Style.fontSize; bold: true}
					Layout.fillWidth: true
				}

				DisplayText {
					text: "Clear"
					font.pixelSize: Style.fontSize * 0.75

					MouseArea {
						anchors.fill: parent
						onClicked: root.history.clear()
					}
				}
			}

			Rectangle {
				color: Style.colMuted
				Layout.fillWidth: true
				Layout.preferredHeight: 2
			}

			Text {
					text: "No notifications"
					visible: root.history.count == 0
					Layout.alignment: Qt.AlignCenter
					color: Style.colMuted
					font {family: Style.fontFamily; pixelSize: Style.fontSize; bold: true}
			}

			ListView {
				id: list
				Layout.fillWidth: true
				Layout.fillHeight: true
				Layout.preferredHeight: contentHeight
				Layout.maximumHeight: 400
				clip: true
				model: root.history
				delegate: NotificationCard {
					id: card
					implicitWidth: list.width
					summary: modelData.summary
					body: modelData.body
					appName: modelData.appName
					urgency: modelData.urgency
					icon: modelData.icon
					time: modelData.time
					actions: modelData.actions

					required property var modelData
					required property int index

					DisplayText {
						text: "x"
						anchors {margins: 5; top: parent.top; right: parent.right}

						MouseArea {
							anchors.fill: parent
							onClicked: root.history.remove(card.index)
						}
					}
				}
			}
		}
	}
}
