pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Hyprland
import Quickshell.Io
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import qs.style
import qs.elements

PanelWindow {
	id: root
	anchors {top: true; right: true}
	margins {top: 30; right: 12}
	implicitWidth: 300
	implicitHeight: Math.max(1, column.implicitHeight)
	exclusionMode: ExclusionMode.Ignore
	color: "transparent"
	screen: Quickshell.screens.find(s => s.name == Hyprland.focusedMonitor.name)

	property int defaultTimeoutInterval: 5000
	property ListModel history: historyModel

	NotificationServer {
		id: server
		bodySupported: true
		actionsSupported: true
		imageSupported: true
		bodyMarkupSupported: true

		onNotification: n => {
			historyModel.insert(0, {
				summary: n.summary,
				body: n.body,
				appName: n.appName,
				urgency: n.urgency,
				icon: n.image || n.appIcon || "",
				time: Qt.formatDateTime(new Date(), "HH:mm"),
				actions: {}//n.actions
			})
			n.tracked = true
		}
	}

	ListModel {
		id: historyModel
	}

	ColumnLayout {
		id: column
		width: parent.width
		spacing: 10

		Repeater {
			model: server.trackedNotifications

			NotificationCard {
				id: card
				Layout.fillWidth: true
				summary: modelData.summary
				body: modelData.body
				urgency: modelData.urgency
				appName: modelData.appName
				icon: modelData.image || modelData.appIcon || ""
				time: Qt.formatDateTime(new Date(), "HH:mm")
				actions: modelData.actions

				required property Notification modelData

				MouseArea {
					anchors.fill: parent 
					acceptedButtons: Qt.RightButton
					onClicked: card.modelData.dismiss()
				}

				Timer {
					running: card.modelData.urgency !== NotificationUrgency.Critical
					interval: card.modelData.expireTimeout > 0 ? card.modelData.expireTimeout : root.defaultTimeoutInterval
					onTriggered: card.modelData.expire()
				}
			}
		}
	}
}
