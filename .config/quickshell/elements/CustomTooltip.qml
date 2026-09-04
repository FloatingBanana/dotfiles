import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import qs.style
import qs.elements

CustomPopup {
	id: tooltip
	flags: Qt.ToolTip
	width: tooltipText.width + 10
	height: tooltipText.height + 10
	opacity: 0.5
	onVisibleChanged: positionUnderItem(target)

	property Item target
	property string text

	DisplayText {
		id: tooltipText
		text: tooltip.text
		anchors.centerIn: parent
	}
}
