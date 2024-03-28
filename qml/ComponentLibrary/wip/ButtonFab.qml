import QtQuick
import QtQuick.Effects
import QtQuick.Controls.impl
import QtQuick.Templates as T

import ThemeEngine
import "qrc:/utils/UtilsNumber.js" as UtilsNumber

T.Button {
    id: control

    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.margins: 24

    implicitWidth: 56
    implicitHeight: 56
    z: 10

    focusPolicy: Qt.NoFocus

    // settings
    property string shape: "squared" // available: rounded, squared
    property int shapeRadius: (shape === "rounded") ? 2 : 4

    // icon
    property url source
    property int sourceSize: 32

    // colors
    property color colorBackground: Theme.colorPrimary
    property color colorHighlight: "white"
    property color colorIcon: "white"

    // animation
    property string animation: "" // available: rotate, fade
    property bool animationRunning: false

    ////////////////////////////////////////////////////////////////////////////

    background: Item {
        implicitWidth: 56
        implicitHeight: 56

        Rectangle {
            anchors.fill: parent
            radius: (width / control.shapeRadius)
            color: control.colorBackground

            layer.enabled: true
            layer.effect: MultiEffect {
                autoPaddingEnabled: true
                shadowEnabled: true
                shadowVerticalOffset: 4
                shadowColor: "#66000000"
            }
        }

        RippleThemed {
            width: parent.width
            height: parent.height

            anchor: control
            pressed: control.pressed
            active: control.enabled && (control.down || control.visualFocus)
            color: Qt.rgba(control.colorHighlight.r, control.colorHighlight.g, control.colorHighlight.b, 0.1)

            layer.enabled: true
            layer.effect: MultiEffect {
                maskEnabled: true
                maskThresholdMin: 0.5
                maskSpreadAtMin: 1.0
                maskSpreadAtMax: 0.0
                maskSource: ShaderEffectSource {
                    sourceItem: Rectangle {
                        x: background.x
                        y: background.y
                        width: background.width
                        height: background.height
                        radius: (background.width / control.shapeRadius)
                    }
                }
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    contentItem: Item {
        IconSvg {
            anchors.centerIn: parent
            width: control.sourceSize
            height: control.sourceSize

            color: control.colorIcon
            opacity: control.enabled ? 1 : 0.66

            visible: control.source.toString().length
            source: control.source

            SequentialAnimation on opacity {
                running: (control.animationRunning &&
                          (control.animation === "fade" || control.animation === "both"))
                alwaysRunToEnd: true
                loops: Animation.Infinite

                PropertyAnimation { to: 0.5; duration: 666; }
                PropertyAnimation { to: 1; duration: 666; }
            }
            NumberAnimation on rotation {
                running: (control.animationRunning &&
                          (control.animation === "rotate" || control.animation === "both"))
                alwaysRunToEnd: true
                loops: Animation.Infinite

                duration: 1500
                from: 0
                to: 360
                easing.type: Easing.Linear
            }
        }
    }

    ////////////////////////////////////////////////////////////////////////////
}
