import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../input"
import "../component"
import "../widget"
import "../library"
import ".."

PanelWindow {
	anchors {
		left: true
		right: true
		top: true
	}

	height: Config.layout.topBar.height
	color: "transparent"
	WlrLayershell.namespace: "shell:bar"

	Rectangle {
		id: barRect
		anchors {
			fill: parent
			margins: Config.layout.topBar.margins
		}

		color: Config.colors.bar.bg
		radius: Config.layout.topBar.radius
		border.color: Config.colors.bar.outline
		border.width: Config.layout.topBar.border

		RowLayout {
			anchors.fill: parent
			RowLayout2 {
				Layout.fillHeight: true
				width: 400

				Text2 {
					function n(n) { return String(n).padStart(2, "0") }
					text: n(Time.time.getDate()) + "/" + n(Time.time.getMonth() + 1) + " " +
						n(Time.time.getHours()) + ":" + n(Time.time.getMinutes()) + ":" + n(Time.time.getSeconds())
				}
				HSpace {}
			}
			RowLayout2 {
				Layout.fillHeight: true
				Layout.fillWidth: true

				Text2 { text: HyprlandIpc.activeWindow.title }
			}
			RowLayout2 {
				Layout.fillHeight: true
				width: 400

				RowLayout2 {
					autoSize: true
					Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
					HoverButton {
						inner: workspacesStatus
						onClicked: ShellIpc.workspacesOverview = !ShellIpc.workspacesOverview
						WorkspacesStatus { id: workspacesStatus }
					}
				}
			}
		}
	}
}
