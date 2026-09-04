import Quickshell
import Quickshell.DBusMenu
import Quickshell.Services.SystemTray
import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import qs.style
import qs.elements

Image {
	id: root
	source: trayItem.icon
	sourceSize.width: Style.fontSize
	sourceSize.height: Style.fontSize
	Layout.preferredWidth: Style.fontSize
	Layout.preferredHeight: Style.fontSize

	required property SystemTrayItem trayItem
	required property var parentWindow

	Rectangle {
		visible: root.trayItem.status == Status.NeedsAttention
		color: Style.colWarning
		anchors.bottom: parent.bottom
		anchors.left: parent.left
		implicitWidth: 6
		implicitHeight: 6
		radius: 5
	}

	MouseArea {
		anchors.fill: parent
		acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
		cursorShape: Qt.PointingHandCursor
		onPressed: {
			if (pressedButtons & Qt.LeftButton) root.trayItem.activate()
			if (pressedButtons & Qt.MiddleButton) root.trayItem.secondaryActivate()
			if (pressedButtons & Qt.RightButton) {
				let origin = root.mapToItem(null, mouseX, mouseY)
				root.trayItem.display(root.parentWindow, origin.x, origin.y)
			}
		}
	}

	QsMenuAnchor {
		menu: root.trayItem.menu
		anchor.window: root.parentWindow
	}
}
