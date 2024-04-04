import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "./input"
import "./component"
import "./window"
import "./library"

ShellRoot {
	WallpaperRandomizer { id: wallpaperRandomizer }

	StatBar { screen: Quickshell.screens[0] }
	MediaBar { screen: Quickshell.screens[0] }

	CPUInfoGrid {
		screen: Quickshell.screens[0]
		anchors.right: true
		height: 480
		width: 48
	}

	HAudioVisualizerBars {
		screen: Quickshell.screens[0]
		fillColor: "#30ffeef8"
		bars: 48
		anchors.top: true
		anchors.left: true
		anchors.right: true
	}

	HAudioVisualizerBars {
		screen: Quickshell.screens[0]
		fillColor: "#30ffeef8"
		bars: 48
		anchors.bottom: true
		anchors.left: true
		anchors.right: true
	}

	LazyLoader {
		id: volumeOsdLoader
		loading: Config.audioProvider.initialized
		VProgressBarWindow { fraction: Config.audioProvider.volume * 0.01 }
	}

	Connections {
		target: Config.audioProvider
		function onVolumeChanged() {
			if (!volumeOsdLoader.active || !volumeOsdLoader.item) return
			if (volumeOsdLoader.item.screen.id !== HyprlandIpc.activeScreen.id) {
				volumeOsdLoader.item.screen = HyprlandIpc.activeScreen
			}
			volumeOsdLoader.item.show()
		}
	}

	WorkspacesOverview { id: workspacesOverview }

	Connections {
		target: ShellIpc
		function onWorkspacesOverviewChanged() {
			workspacesOverview.visible = ShellIpc.workspacesOverview
			if (!workspacesOverview.visible) return
			if (workspacesOverview.screen.id !== HyprlandIpc.activeScreen.id) {
				workspacesOverview.screen = HyprlandIpc.activeScreen
			}
		}
	}

	PersistentProperties {
		onLoaded: workspacesOverview.visible = ShellIpc.workspacesOverview
	}

	Variants {
		model: Quickshell.screens

		Scope {
			required property var modelData

			PanelWindow {
				id: window
				screen: modelData
				WlrLayershell.layer: WlrLayer.Background
				anchors { top: true; bottom: true; left: true; right: true }

				Image {
					anchors.fill: parent
					fillMode: Image.PreserveAspectCrop
					source: wallpaperRandomizer.wallpapers[modelData.name] ?? "blank.png"
					asynchronous: false
				}

				// ShaderView {}

				SelectionLayer {
					id: selectionLayer

					onSelectionComplete: (x, y, width, height) => {
						termSpawner.x = x
						termSpawner.y = y
						termSpawner.width = width
						termSpawner.height = height
						termSpawner.running = true
					}

					Process {
						id: termSpawner
						property real x
						property real y
						property real width
						property real height

						command: [
							"hyprctl",
							"dispatch",
							"exec",
							`[float;; noanim; move ${x} ${y}; size ${width} ${height}] alacritty --class AlacrittyTermselect`
						]
					}

					Connections {
						target: ShellIpc

						function onTermSelectChanged() {
							if (ShellIpc.termSelect) {
								selectionLayer.selectionArea.startSelection(true)
							} else {
								selectionLayer.selectionArea.endSelection()
							}
						}
					}

					Connections {
						target: HyprlandIpc

						function onWindowOpened(_, _, klass, _) {
							if (klass === "AlacrittyTermselect") {
								selectionLayer.selectionArea.selecting = false
							}
						}
					}
				}

				SelectionArea {
					anchors.fill: parent
					screen: window.screen
					selectionArea: selectionLayer.selectionArea
				}
			}
		}
	}
}
