import Quickshell
import QtQuick
import qs.style

Text {
	id: root
	color: Style.colFg
	font {family: Style.fontFamily; pixelSize: Style.fontSize; bold: true}

	Rectangle {
		id: activeBar
		anchors.left: parent.left
		anchors.right: parent.right
		anchors.bottom: parent.bottom
		implicitHeight: 2
		color: root.color
		opacity: 0

		Behavior on opacity {
			NumberAnimation {
				duration: 200
			}
		}
	}

	HoverHandler {
		onHoveredChanged: hovered ? activeBar.opacity = 1 : activeBar.opacity = 0
		cursorShape: Qt.PointingHandCursor
	}
}
