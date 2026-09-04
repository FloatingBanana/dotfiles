import Quickshell
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import qs.style
import qs.elements

Slider {
	id: root

	handle: Rectangle {
		x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
		y: root.topPadding + root.availableHeight / 2 - height / 2
		implicitWidth: Style.fontSize
		implicitHeight: Style.fontSize
		radius: 13
		color: root.pressed ? Style.colActive : Style.colFg
	}

	background: Rectangle {
		x: root.leftPadding
		y: root.topPadding + root.availableHeight / 2 - height / 2
		implicitWidth: parent.implicitWidth
		implicitHeight: parent.implicitHeight
		radius: 2
		color: Style.colMuted

		Rectangle {
				width: root.visualPosition * parent.width
				height: parent.height
				color: Style.colFg
				radius: 2
		}
	}
}
