import Quickshell
import QtQuick
import QtQuick.Layouts
import qs.barComponents
import qs.style

PanelWindow {
	id: root
	anchors {top: true; left: true; right: true}
	color: Style.colBg
	implicitHeight: 30

	required property ListModel notificationHistory

	RowLayout {
		anchors.fill: parent
		anchors.margins: 8
		spacing: 8

		AppRunner {currentScreen: root.screen}
		
		Workspaces {}

		Separator {}

		AppIconsDisplay {}

		Item { Layout.fillWidth: true }

		SystemTrayDisplay {parentWindow: root}

		Separator {}

		AudioController {}

		BluetoothController {}

		Separator {}

		CpuMonitor {}

		MemoryMonitor {}

		StorageMonitor {}

		EthernetMonitor {}

		Separator {}

		WheaterMonitor {}

		Clock {}

		Separator {}

		NotificationCenter {history: notificationHistory}

		Separator {}

		Powermenu {}
	}
}

