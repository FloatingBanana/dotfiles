import QtQuick
import Quickshell.Io
import qs.style
import qs.elements

DisplayText {
	id: memText

	Process {
		id: memProc
		command: ["sh", "-c", "free | grep Mem"]
		stdout: SplitParser {
			onRead: data => {
				if (!data) return
				var p = data.trim().split(/\s+/)
				var total = parseInt(p[1]) || 1
				var used = parseInt(p[2]) || 0
				memText.text = " " + Math.round(100 * used / total) + "%"
			}
		}
		Component.onCompleted: running = true
	}

	Timer {
		interval: 2000
		running: true
		repeat: true
		onTriggered: memProc.running = true
		triggeredOnStart: true
	}
}
