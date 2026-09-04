import Quickshell
import QtQuick
import QtQuick.Window
import qs.style
import qs.elements

Window {
	id: root
	flags: Qt.Popup
	color: "transparent"

	Rectangle {
		id: background
		anchors.fill: parent
		radius: 10
		color: Style.colBg
		opacity: root.opacity

		Behavior on opacity {
			NumberAnimation {duration: 500}
		}
	}

	Shortcut {
		sequence: "Escape"
		context: Qt.WindowShortcut
		onActivated: root.close()
	}

	function positionUnderItem(target) {
		let pos = target.mapToItem(null, (target.width - this.width) / 2, target.height)
		this.x = pos.x + target.Window.window.x
		this.y = pos.y + target.Window.window.y
	}
}
