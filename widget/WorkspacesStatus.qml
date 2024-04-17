import QtQuick
import QtQuick.Layouts
import Quickshell
import "../io"
import "../component"
import ".."

RowLayout2 {
	autoSize: true
	Repeater {
		model: Hyprland.workspaceInfosArray
		Text2 {
			Layout.minimumWidth: 13
			required property var modelData
			text: modelData.name
			color: modelData.focused
				? Config.colors.workspaceIndicator.focused
				: modelData.exists
					? Config.colors.workspaceIndicator.visible
					: Config.colors.workspaceIndicator.empty
		}
	}
}
