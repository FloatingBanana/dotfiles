//@ pragma UseQApplication
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick

ShellRoot {
	id: root

	Variants {
		model: Quickshell.screens

		delegate: Item {
			id: item
			required property var modelData

			Bar{
				screen: item.modelData
				notificationHistory: notificationManager.history
			}

			Wallpaper {
				screen: item.modelData
				source: wallpaperFile.text().trim()
			}
		} 
	}

	FileView {
		id: wallpaperFile
		path: Quickshell.env("HOME") + "/.cache/wallpaper"
		watchChanges: true
	}

	NotificationManager {
		id: notificationManager
	}
}

