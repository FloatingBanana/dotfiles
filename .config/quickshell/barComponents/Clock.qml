pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Bluetooth
import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.Controls
import qs.style
import qs.elements

DisplayText {
	id: root

	Timer {
		interval: 10000
		running: true
		repeat: true
		onTriggered: root.text =  Qt.formatDateTime(new Date(), "ddd dd/MM/yy HH:mm")
		triggeredOnStart: true
	}

	MouseArea {
		anchors.fill: parent
		acceptedButtons: Qt.LeftButton
		onPressed: calendarPopup.show()
	}

	CustomPopup {
		id: calendarPopup
		width: calendarLayout.childrenRect.width + 20
		height: calendarLayout.childrenRect.height + 20
		onVisibleChanged: positionUnderItem(root)

		ColumnLayout {
			id: calendarLayout
			anchors.centerIn: parent
			anchors.margins: 10

			RowLayout {
				CustomButton {
					text: "<"
					onClicked: {
						if (calendarMonth.month == Calendar.January) {
 							calendarMonth.year -= 1
 							calendarMonth.month = Calendar.December
						}
						else calendarMonth.month -= 1
					}
				}

				Item {Layout.fillWidth: true}

				DisplayText {
					text: Qt.formatDateTime(new Date(calendarMonth.year, calendarMonth.month), "MMMM yyyy")

					MouseArea {
						anchors.fill: parent
						onClicked: {
							var currDate = new Date()
							calendarMonth.month = currDate.getMonth()
							calendarMonth.year = currDate.getFullYear()
						}
					}
				}

				Item {Layout.fillWidth: true}

				CustomButton {
					text: ">"
					onClicked: {
						if (calendarMonth.month == Calendar.December) {
 							calendarMonth.year += 1
 							calendarMonth.month = Calendar.January
						}
						else calendarMonth.month += 1
					}
				}
			}

			DayOfWeekRow {
				Layout.fillWidth: true

				delegate: Text {
					text: shortName
					font {family: Style.fontFamily; pixelSize: Style.fontSize; bold: true}
					color: Style.colFg
					required property string shortName
				}
			}

			MonthGrid {
				id: calendarMonth
				font {family: Style.fontFamily; pixelSize: Style.fontSize; bold: true}
				Layout.fillWidth: true
				Layout.fillHeight: true

				delegate: Text {
					text: model.day
					font {family: Style.fontFamily; pixelSize: Style.fontSize; bold: true}
					color: model.today ? Style.colConnected : Style.colFg
					opacity: model.month === calendarMonth.month ? 1 : 0.2

					required property var model
				}
			}
		}
	}
}
