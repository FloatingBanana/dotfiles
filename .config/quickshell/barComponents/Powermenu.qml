import Quickshell
import QtQuick
import qs.style
import qs.elements

DisplayText {
	id: root
	text: " 󰐥 "

	MouseArea {
		anchors.fill: parent
		onClicked: Quickshell.execDetached({
			command: ["sh", "-c", "$HOME/scripts/powermenu.sh"]
		})
	}
}
