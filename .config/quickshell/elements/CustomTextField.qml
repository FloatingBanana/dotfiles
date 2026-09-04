import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import qs.style
import qs.elements

TextField {
	id: root
	color: Style.colFg
	selectionColor: Style.colFg
	selectedTextColor: Style.colMuted
	placeholderTextColor: Style.colInactive
	font {family: Style.fontFamily; pixelSize: Style.fontSize * 2; bold: true}

	background: Rectangle {
		radius: 10
		color: Style.colMuted
		width: parent.width
		height: parent.height
		border {width: 4; color: Style.colFg}
	}
}
