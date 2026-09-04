pragma ComponentBehavior: Bound

import Quickshell.Hyprland
import QtQuick
import qs.style
import qs.elements

Repeater {
	id: root
	model: 10

	DisplayText {
		required property int index
		property var ws: Hyprland.workspaces.values.find(w => w.id == index + 1)
		property bool isActive: Hyprland.focusedWorkspace?.id == (index + 1)

		text: index + 1
		color: isActive ? Style.colActive : (ws ? Style.colInactive : Style.colMuted)

		MouseArea {
			anchors.fill: parent
			onClicked: Hyprland.dispatch("hl.dsp.focus({ workspace = " + (parent.index + 1) + " })")
		}
	}
}
