import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import qs.style
import qs.elements

RowLayout {
	id: root

	property var parentWindow
	property list<SystemTrayItem> activeItems: SystemTray.items.values.filter(item => item.status != Status.Passive)
	property list<SystemTrayItem> passiveItems: SystemTray.items.values.filter(item => item.status == Status.Passive)

	Repeater {
		model: root.activeItems

		SystemTrayDisplayItem {
			trayItem: modelData
			parentWindow: root.parentWindow
			required property SystemTrayItem modelData
		}
	}

	DisplayText {
		id: passiveTrayIcon
		text: passiveArea.visible ? "" : ""
		visible: root.passiveItems.length > 0
		
		MouseArea {
			anchors.fill: parent
			onClicked: {
				passiveArea.visible = !passiveArea.visible
			}
		}
	}

	RowLayout {
	id: passiveArea
	visible: false
	
		Repeater {
			model: root.passiveItems

			SystemTrayDisplayItem {
				trayItem: modelData
				parentWindow: root.parentWindow
				required property SystemTrayItem modelData
			}
		}
	}
}
