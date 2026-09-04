import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Io
import qs.style
import qs.elements

DisplayText {
	id: root
	property var info

	CustomTooltip {
		id: tooltip
		target: root

		Process {
			command: ["sh", "-c", "lsblk -o NAME,SIZE,FSUSED,FSUSE%,MOUNTPOINT | column -t -o '     '"]
			stdout: StdioCollector {
				onStreamFinished: tooltip.text = text
			}
			running: tooltip.visible
		}
	}

	MouseArea {
		anchors.fill: parent
		hoverEnabled: true
		onHoveredChanged: containsMouse ? tooltip.show() : tooltip.close()
		onClicked: Quickshell.execDetached({command: ["sh", "-c", "~/scripts/mount-partitions.sh"]})
	}

	Process {
		id: proc
		command: ["lsblk", "-o", "FSUSE%", "--noheadings", "/dev/sdb2"]
		stdout: SplitParser {
			onRead: data => root.text = " " + data
		}
		Component.onCompleted: running = true
	}

	Timer {
		interval: 60000
		running: true
		repeat: true
		onTriggered: proc.running = true
		triggeredOnStart: true
	}
}
