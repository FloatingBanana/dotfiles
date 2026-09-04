import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Widgets
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import qs.style
import qs.elements

Rectangle {
	id: root
	radius: 8
	color: Style.colBg
	border.width: 2
	border.color: urgency === NotificationUrgency.Critical ? Style.colWarning : Style.colFg
	implicitWidth: layout.implicitWidth + 20
	implicitHeight: layout.implicitHeight + 20

	required property string summary
	required property string body
	required property int urgency
	required property string icon
	required property string appName
	required property string time
	required property var actions

	ColumnLayout {
		id: layout
		anchors {fill: parent; margins: 10}

		Text {
			text: (root.appName !== "" ? root.appName + " - " : "") + root.time
			color: Style.colInactive
			font {family: Style.fontFamily; pixelSize: Style.fontSize * 0.65; bold: true}
		}

		RowLayout {
			spacing: 10

			IconImage {
				source: root.icon
				Layout.preferredWidth: 36
				Layout.preferredHeight: 36
				Layout.alignment: Qt.AlignTop
				visible: root.icon != ""
			}

			ColumnLayout {
				Layout.fillWidth: true
				spacing: 2

				Text {
					text: root.summary
					color: Style.colFg
					font {family: Style.fontFamily; pixelSize: Style.fontSize; bold: true}
					elide: Text.ElideRight
					Layout.fillWidth: true
				}

				Text {
					text: root.body
					color: Style.colMuted
					font {family: Style.fontFamily; pixelSize: Style.fontSize - 1; bold: true}
					visible: text !== ""
					wrapMode: Text.WordWrap
					Layout.fillWidth: true
				}
			}
		}

		Flow {
			flow: Flow.LeftToRight
			Layout.fillWidth: true
			spacing: 2

			Repeater {
				model: root.actions

				CustomButton {
					text: modelData.text
					height: Style.fontSize * 1.5
					onClicked: modelData.invoke()
					required property NotificationAction modelData
				}
			}
		}
	}
}
