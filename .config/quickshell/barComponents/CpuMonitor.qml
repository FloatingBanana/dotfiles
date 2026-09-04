import QtQuick
import Quickshell.Io
import qs.style
import qs.elements

DisplayText {
	id: cpuText

	Process {
		id: cpuProc
		command: ["sh", "-c", "head -1 /proc/stat"]
		stdout: SplitParser {
			property int lastCpuIdle: 0
			property int lastCpuTotal: 0

			onRead: data => {
				if (!data) return

				var p = data.trim().split(/\s+/)
				var idle = parseInt(p[4]) + parseInt(p[5])
				var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)

				if(lastCpuTotal > 0) {
					var usage = Math.round(100 * (1 - (idle - lastCpuIdle) / (total - lastCpuTotal)))
					cpuText.text = " " + usage + "%"
				}
				lastCpuTotal = total
				lastCpuIdle = idle
			}
		}
		Component.onCompleted: running = true
	}

	Timer {
		interval: 2000
		running: true
		repeat: true
		onTriggered: cpuProc.running = true
		triggeredOnStart: true
	}
}
