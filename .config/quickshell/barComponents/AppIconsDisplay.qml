pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import Quickshell.Wayland
import qs.style
import qs.elements

RowLayout {
	id: root
	visible: DesktopEntries.applicationsChanged

	Repeater {
		model: ToplevelManager.toplevels

		IconImage {
			id: appIcon
			visible: !entry.noDisplay
			source: "image://icon/" + entry.icon
			Layout.preferredWidth: Style.fontSize
			Layout.preferredHeight: Style.fontSize

			required property var modelData
			property DesktopEntry entry: DesktopEntries.byId(modelData.appId)


			Rectangle {
				visible: appIcon.modelData.activated
				color: Style.colFg
				anchors.centerIn: parent
				implicitWidth: Style.fontSize + 4
				implicitHeight: Style.fontSize + 4
				radius: 4
				z: -1
			}

			MouseArea {
				id: mouseArea
				anchors.fill: parent
				acceptedButtons: Qt.LeftButton | Qt.MiddleButton
				cursorShape: Qt.PointingHandCursor
				hoverEnabled: true
				onHoveredChanged: {
					if (containsMouse) {
						tooltip.text = appIcon.modelData.title
						tooltip.target = this
					}
					containsMouse ? tooltip.show() : tooltip.close()
				}
				onPressed: {
					if (pressedButtons & Qt.LeftButton) appIcon.modelData.activate()
					if (pressedButtons & Qt.MiddleButton) appIcon.modelData.close()
				}
			}
		}
	}

	CustomTooltip {
		id: tooltip
	}
}
