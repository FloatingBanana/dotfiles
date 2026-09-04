import Quickshell
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import qs.style
import qs.elements

TabButton {
	id: root

	contentItem: Text {
		id: text
		text: root.text
		color: root.enabled ? (root.checked ? Style.colBg : Style.colFg) : Style.colInactive
		font {family: Style.fontFamily; pixelSize: Style.fontSize; bold: true}
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
		elide: Text.ElideRight
	}

	background: Rectangle {
		color: root.checked ? Style.colFg : Style.colBg
		border.color: root.enabled ? Style.colFg : Style.colInactive
		border.width: 1
		radius: 5
	}
}
