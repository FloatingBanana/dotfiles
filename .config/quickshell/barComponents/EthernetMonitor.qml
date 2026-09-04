import QtQuick
import Quickshell.Io
import qs.style
import qs.elements

DisplayText {
	id: root

	property var devices: []
	property var devicesLast: []

	CustomTooltip {
		id: tooltip
		target: root
	}

	MouseArea {
		anchors.fill: parent
		hoverEnabled: true
		onHoveredChanged: containsMouse ? tooltip.show() : tooltip.close()
	}

	Process {
		id: listDevicesProc
		command: ["sh", "-c", "ls --ignore=lo /sys/class/net/ | xargs -I{} sh -c 'echo {} $(cat /sys/class/net/{}/statistics/rx_bytes) $(cat /sys/class/net/{}/statistics/tx_bytes) $(cat /sys/class/net/{}/operstate)'"]
		stdout: SplitParser {
			onRead: data => {
				if (!data) return

				const values = data.trim().split(/\s+/)
				root.devices.push({name: values[0], download: parseInt(values[1]), upload: parseInt(values[2]), status: values[3]})
			}
		}
		onExited: {
			root.text = root.devices.find(d => d.status === "up") != [] ? "󰛳" : "󰲛"

			const dev = root.devices[0]
			const devLast = root.devicesLast.find(d => d.name === dev.name)

			tooltip.text = ` ${root.speedText(dev?.upload - devLast?.upload)}  ${root.speedText(dev?.download - devLast?.download)}`
		}
	}

	Timer {
		interval: 2000
		running: true
		repeat: true
		onTriggered: root.update()
		triggeredOnStart: true
	}

	function speedText(bytes: int): string {
		let label = "B"
		for (const l of ["Kb", "Mb", "Gb"]) {
			if (bytes < 1024) break
			bytes /= 1024
			label = l
		}
		return `${bytes.toFixed(2)}${label}/s`
	}

	function update(): void {
		devicesLast = devices
		devices = []
		listDevicesProc.running = true
	}
}
