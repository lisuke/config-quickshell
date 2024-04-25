import QtQuick
import Quickshell
import "../io"
import "../library"

ConfigShared {
	id: root

	property QtObject colors: QtObject {
		property string backgroundBlend: "#00000000"
		property QtObject textSelection: QtObject {
			property string bg: "#20e0ffff"
		}

		// fallback values for arbitrary rectangles
		property QtObject rectangle: QtObject {
			property string bg: "#30ffeef8"
		}

		property QtObject accent: QtObject {
			property string fg: "#a0ffaaaa"
		}

		property QtObject bar: QtObject {
			property string bg: "#00e0ffff"
			property string outline: "#00ffffff"
		}

		property QtObject barItem: QtObject {
			property string bg: "#00e0ffff"
			property string hoverBg: "#20e0ffff"
			property string outline: "#00ffffff"
		}

		property QtObject widget: QtObject {
			property string fg: "#a0ffffff"
			property string bg: "#40e0ffff"
			property string accent: root.colors.accent.fg
			property string hoverBg: "#60e0ffff"
			property string outline: "#00ffffff"
		}

		property QtObject button: QtObject {
			property string fg: root.colors.widget.fg
			property string bg: "#00e0ffff"
			property string accent: root.colors.accent.fg
			property string hoverBg: root.colors.widget.hoverBg
			property string outline: root.colors.widget.outline
		}

		property QtObject window: QtObject {
			property string fg: root.colors.widget.fg
			property string bg: "#20e0ffff"
			property string accent: root.colors.widget.accent
			property string hoverBg: root.colors.widget.hoverBg
			property string outline: root.colors.widget.outline
		}

		property QtObject panel: QtObject {
			property string fg: root.colors.window.fg
			property string bg: root.colors.window.bg
			property string accent: root.colors.window.accent
			property string hoverBg: root.colors.window.hoverBg
			property string outline: root.colors.window.outline
		}

		property QtObject greeter: QtObject {
			property string fg: "#40e0ffff"
			property string bg: root.colors.panel.bg
			property string outline: root.colors.panel.outline
		}

		property QtObject activateLinux: QtObject {
			property string fg: "#40e0ffff"
			property string bg: root.colors.panel.bg
			property string outline: root.colors.panel.outline
		}

		property QtObject selection: QtObject {
			property string bg: "#66001017"
			property string outline: "#ee33ccff"
			property string outlineInvalid: "#aa595959"
		}

		property QtObject workspaceIndicator: QtObject {
			property string focused: root.colors.accent.fg
			property string visible: "#80ffffff"
			property string empty: "#20ffffff"
		}

		property QtObject audioVisualizer: QtObject {
			property string barsBg: "#30ffeef8"
		}
	}
}
