import Quickshell
import Quickshell.Bluetooth
import Quickshell.Widgets
import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import qs.style
import qs.elements

DisplayText {
	id: root
	color: adapter.enabled ? Style.colFg : Style.colWarning
	text: {
		if (!adapter.enabled) return "󰂲"
		var connectedDevices = adapter.devices.values.filter(d => d.connected)

		if (connectedDevices.length > 0) {
			var devicesWithBattery = connectedDevices.filter(d => d.batteryAvailable)
			if (devicesWithBattery.length > 0) return `󰂱 ${devicesWithBattery[0].battery * 100}%`
			
			return "󰂱" 
		}
		return "󰂯"
	}

	property BluetoothAdapter adapter: Bluetooth.defaultAdapter

	MouseArea {
		anchors.fill: parent
		acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
		onPressed: {
			if (pressedButtons & Qt.LeftButton) devicesPopup.show()
			if (pressedButtons & Qt.MiddleButton) root.adapter.enabled = !root.adapter.enabled
		}
	}

	CustomPopup {
		id: devicesPopup
		width: btLayout.childrenRect.width + 20
		height: btLayout.childrenRect.height + 20
		onVisibleChanged: positionUnderItem(root)


		ColumnLayout {
			id: btLayout
			anchors.margins: 10
			anchors.centerIn: parent
			spacing: 10

			RowLayout {
				Layout.minimumWidth: 300

				Text {
					text: root.adapter.name + (root.adapter.discovering ? "(searching)" : "")
					color: Style.colFg
					font {family: Style.fontFamily; pixelSize: Style.fontSize; bold: true}
				}

				Item {Layout.fillWidth: true}
				
				CustomButton {
					width: 80
					height: Style.fontSize + 5
					text: root.adapter.discovering ? "Stop" : "Search"
					onClicked: root.adapter.discovering = !root.adapter.discovering
				}
			}

			Rectangle { Layout.fillWidth: true; implicitHeight: 1; color: Style.colFg}

			Repeater {
				model: root.adapter.devices

				RowLayout {
					id: itemLayout
					required property BluetoothDevice modelData

					IconImage {
						width: Style.fontSize
						height: Style.fontSize
						source: Quickshell.iconPath(itemLayout.modelData.icon, true)
					}

					Text {
						text: itemLayout.modelData.name
						color: itemLayout.modelData.connected ? Style.colConnected : Style.colFg
						font {family: Style.fontFamily; pixelSize: Style.fontSize; bold: true}
					}

					Item {Layout.fillWidth: true}

					CustomButton {
						text: switch(itemLayout.modelData.state) {
							case BluetoothDevice.Connected: return "Disconnect";
							case BluetoothDevice.Disconnected: return "Connect";
							case BluetoothDevice.Connecting: return "Connecting";
							case BluetoothDevice.Disconnecting: return "Disconnecting";
						}
						onClicked: itemLayout.modelData.connected = !itemLayout.modelData.connected
						visible: itemLayout.modelData.paired
						enabled: itemLayout.modelData.state === BluetoothDeviceState.Connected || itemLayout.modelData.state === BluetoothDeviceState.Disconnected
					}
					CustomButton {
						text: itemLayout.modelData.paired ? "Unpair" : (itemLayout.modelData.pairing ? "Cancel" : "Pair")
						onClicked: itemLayout.modelData.paired ? itemLayout.modelData.forget() : (itemLayout.modelData.pairing ? itemLayout.modelData.cancelPair() : itemLayout.modelData.pair())
					}
				}
			}
		}
	}
}
