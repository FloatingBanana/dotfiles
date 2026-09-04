pragma ComponentBehavior: Bound

import QtMultimedia
import Quickshell
import Quickshell.Wayland
import QtQuick
import qs.style
import qs.elements

PanelWindow {
	id: root
	anchors {left: true; right: true; top: true; bottom: true}
	WlrLayershell.layer: WlrLayer.Background

	required property string source

	onSourceChanged: {
		if (source.split(".").pop() === "mp4") {
			imageBg.source = ""
			videoBg.source = "file://" + source
		} else {
			imageBg.source = source
			videoBg.source = ""
		}
	}

	Image {
		id: imageBg
		visible: source !== ""
		anchors.fill: parent
		sourceSize {width: root.screen.width; height: root.screen.height}
		fillMode: Image.PreserveAspectCrop
	}

	Video {
		id: videoBg
		visible: source !== ""
		anchors.fill: parent
		autoPlay: true
		fillMode: VideoOutput.PreserveAspectCrop
		loops: MediaPlayer.Infinite
		onErrorOccurred: (_, errors) => {
			console.log(errors)
		}
	}
}
