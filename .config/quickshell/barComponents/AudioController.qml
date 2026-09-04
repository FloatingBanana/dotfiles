pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import qs.style
import qs.elements

DisplayText {
	id: root
	color: sink.audio.muted ? Style.colWarning : Style.colFg
	text: ` ${String(Math.round(sink.audio.volume * 100)).padStart(2, " ")}%`
	visible: sink !== null

	property PwNode sink: Pipewire.defaultAudioSink

	PwObjectTracker {
		id: tracker
		objects: Pipewire.nodes.values.filter(n => n.audio != null)
	}
		
	MouseArea {
		anchors.fill: parent
		acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
		onPressed: {
			if (pressedButtons & Qt.LeftButton) sliderPopup.show()
			if (pressedButtons & Qt.RightButton) sinkListPopup.show()
			if (pressedButtons & Qt.MiddleButton) root.sink.audio.muted = !root.sink.audio.muted
		}
	}

	CustomPopup {
		id: sliderPopup
		width: 200
		height: 25
		onVisibleChanged: positionUnderItem(root)
		
		CustomSlider {
			anchors.centerIn: parent
			from: 0
			to: 1
			implicitWidth: sliderPopup.width - 20
			implicitHeight: 4
			value: root.sink.audio.volume
			onMoved: {
				root.sink.audio.volume = this.value
			}
		}
	}

	function getNodeName(node) {
		if (node.properties["application.name"]) return node.properties["application.name"]
		if (node.nickname != "") return node.nickname
		if (node.description != "") return node.description
		if (node.name != "") return node.name
	}

	CustomPopup {
		id: sinkListPopup
		width: sinkLayout.childrenRect.width + 20
		height: sinkLayout.childrenRect.height + 20
		onVisibleChanged: positionUnderItem(root)

		ColumnLayout {
			id: sinkLayout
			anchors.margins: 10
			anchors.centerIn: parent
			spacing: 10

			DisplayText { text: "Sources:" }

			Repeater {
				//model: tracker.objects.filter(node => !node.isSink)
				model: Pipewire.linkGroups.values.map(l => l.source)

				RowLayout {
					id: inputItemLayout
					required property PwNode modelData

					DisplayText {
						text: "   " + root.getNodeName(inputItemLayout.modelData)

						MouseArea {
							anchors.fill: parent
							acceptedButtons: Qt.RightButton
							visible: inputItemLayout.modelData.audio != null && inputItemLayout.modelData.audio.channels.length > 0
							onClicked: {
								channelListPopup.selectedNode = inputItemLayout.modelData
								sinkListPopup.close()
								channelListPopup.show()
							}
						}
					}

					Item {Layout.fillWidth: true}

					CustomSlider {
						from: 0
						to: 1
						implicitWidth: 200
						implicitHeight: 4
						value: inputItemLayout.modelData.audio.volume
						onMoved: inputItemLayout.modelData.audio.volume = this.value
					}
				}
			}

			DisplayText { text: "Sinks:" }

			Repeater {
				model: tracker.objects.filter(node => node.isSink)
				//model: Pipewire.linkGroups.values.map(l => l.target)

				RowLayout {
					id: outputItemLayout
					required property PwNode modelData

					CustomRadioButton {
						text: root.getNodeName(outputItemLayout.modelData)
						checked: outputItemLayout.modelData.name === Pipewire.defaultAudioSink.name
						onClicked: Pipewire.preferredDefaultAudioSink = outputItemLayout.modelData

						MouseArea {
							anchors.fill: parent
							acceptedButtons: Qt.RightButton
							visible: outputItemLayout.modelData.audio != null && outputItemLayout.modelData.audio.channels.length > 0
							onClicked: {
								channelListPopup.selectedNode = outputItemLayout.modelData
								sinkListPopup.close()
								channelListPopup.show()
							}
						}
					}

					Item {Layout.fillWidth: true}

					CustomSlider {
						from: 0
						to: 1
						implicitWidth: 200
						implicitHeight: 4
						value: outputItemLayout.modelData.audio.volume
						onMoved: outputItemLayout.modelData.audio.volume = this.value
					}
				}
			}
		}
	}

	CustomPopup {
		id: channelListPopup
		width: channelLayout.childrenRect.width + 20
		height: channelLayout.childrenRect.height + 20
		onVisibleChanged: positionUnderItem(root)

		property PwNode selectedNode: null

		ColumnLayout {
			id: channelLayout
			anchors.margins: 10
			anchors.centerIn: parent
			spacing: 10

			DisplayText { text: root.getNodeName(channelListPopup.selectedNode) }

			Repeater {
				model: channelListPopup.selectedNode.audio?.channels

				RowLayout {
					id: channelItemLayout
					required property var modelData
					required property int index

					DisplayText {
						text: "   " + PwAudioChannel.toString(channelItemLayout.modelData)
					}

					Item {Layout.fillWidth: true}

					CustomSlider {
						from: 0
						to: 1
						implicitWidth: 200
						implicitHeight: 4
						value: channelListPopup.selectedNode.audio.volumes[channelItemLayout.index]
						onMoved: channelListPopup.selectedNode.audio.volumes[channelItemLayout.index] = this.value
					}
				}
			}
		}
	}
}
