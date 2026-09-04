import Quickshell
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import qs.style
import qs.elements

RadioButton {
	id: root

	contentItem: DisplayText {
		text: root.text
		verticalAlignment: Text.AlignVCenter
		leftPadding: root.indicator.width + root.spacing
	}

	indicator: Rectangle {
		implicitWidth: Style.fontSize
		implicitHeight: Style.fontSize
		color: root.checked ? Style.colFg : Style.colMuted
		x: root.leftPadding
		y: (parent.height - height) / 2
		radius: 13
	}
}
