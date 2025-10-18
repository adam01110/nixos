import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Hyprland
import "../../common"
import "../../services"
import "."

Scope {
    id: overviewScope
    Variants {
        id: overviewVariants
        model: Quickshell.screens
        PanelWindow {
            id: root
            required property var modelData
            readonly property HyprlandMonitor monitor: Hyprland.monitorFor(root.screen)
            property bool monitorIsFocused: (Hyprland.focusedMonitor?.id == monitor?.id)
            screen: modelData
            visible: GlobalStates.overviewOpen

            WlrLayershell.namespace: "quickshell:overview"
            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive
            color: "transparent"

            mask: Region {
                item: GlobalStates.overviewOpen ? keyHandler : null
            }

            anchors {
                top: true
                bottom: true
                left: !(Config?.options.overview.enable ?? true) 
                right: !(Config?.options.overview.enable ?? true) 
            }

            HyprlandFocusGrab {
                id: grab
                windows: [root]
                property bool canBeActive: root.monitorIsFocused
                active: false
                onCleared: () => {
                    if (!active)
                        GlobalStates.overviewOpen = false;
                }
            }

            Connections {
                target: GlobalStates
                function onOverviewOpenChanged() {
                    if (GlobalStates.overviewOpen) {
                        delayedGrabTimer.start();
                    }
                }
            }

            Timer {
                id: delayedGrabTimer
                interval: Config.options.hacks.arbitraryRaceConditionDelay
                repeat: false
                onTriggered: {
                    if (!grab.canBeActive)
                        return;
                    grab.active = GlobalStates.overviewOpen;
                }
            }

            implicitWidth: columnLayout.implicitWidth
            implicitHeight: columnLayout.implicitHeight

            Item {
                id: keyHandler
                anchors.fill: parent
                visible: GlobalStates.overviewOpen
                focus: GlobalStates.overviewOpen

                Keys.onPressed: event => {
                    if (event.key === Qt.Key_Escape) {
                        GlobalStates.overviewOpen = false;
                        event.accepted = true;
                    } else if (event.key === Qt.Key_Left || event.key === Qt.Key_Right) {
                        const workspacesPerGroup = Config.options.overview.rows * Config.options.overview.columns;
                        const currentId = Hyprland.focusedMonitor?.activeWorkspace?.id ?? 1;
                        const currentGroup = Math.floor((currentId - 1) / workspacesPerGroup);
                        const minWorkspaceId = currentGroup * workspacesPerGroup + 1;
                        const maxWorkspaceId = minWorkspaceId + workspacesPerGroup - 1;
                        
                        let targetId;
                        if (event.key === Qt.Key_Left) {
                            targetId = currentId - 1;
                            if (targetId < minWorkspaceId) targetId = maxWorkspaceId;
                        } else {
                            targetId = currentId + 1;
                            if (targetId > maxWorkspaceId) targetId = minWorkspaceId;
                        }
                        
                        Hyprland.dispatch("workspace " + targetId);
                        event.accepted = true;
                    }
                }
            }

            ColumnLayout {
                id: columnLayout
                visible: GlobalStates.overviewOpen
                anchors.centerIn: parent

                Loader {
                    id: overviewLoader
                    active: GlobalStates.overviewOpen && (Config?.options.overview.enable ?? true)
                    sourceComponent: OverviewWidget {
                        panelWindow: root
                        visible: true
                    }
                }
            }
        }
    }
    
    IpcHandler {
        target: "overview"

        function toggle() {
            GlobalStates.overviewOpen = !GlobalStates.overviewOpen;
        }
        function close() {
            GlobalStates.overviewOpen = false;
        }
        function open() {
            GlobalStates.overviewOpen = true;
        }
    }
}
