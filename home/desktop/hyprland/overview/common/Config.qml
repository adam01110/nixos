pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell

Singleton {
    id: root
    
    property QtObject options: QtObject {
        property QtObject overview: QtObject {
            property int rows: 2
            property int columns: 4
            property real scale: 0.12
            property bool enable: true
        }
        
        property QtObject hacks: QtObject {
            property int arbitraryRaceConditionDelay: 150
        }
    }
}
