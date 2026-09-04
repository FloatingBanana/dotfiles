import QtQuick
import Quickshell.Io
import qs.style
import qs.elements

DisplayText {
	id: wheaterText
	visible: this.text !== ""

	Process {
		id: weatherProc
		command: ["curl", "wttr.in/?format=%c%t"]
		stdout: SplitParser {
			onRead: data => {
				if (!data) return
				wheaterText.text = data.trim()
			}
		}
		Component.onCompleted: running = true
	}

	Timer {
		interval: 5*60*1000
		running: true
		repeat: true
		onTriggered: weatherProc.running = true
		triggeredOnStart: true
	}
}
