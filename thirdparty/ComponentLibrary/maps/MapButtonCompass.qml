import QtQuick
import QtQuick.Effects
import QtQuick.Controls.impl
import QtQuick.Templates as T

import ComponentLibrary

T.Button {
    id: control

    implicitWidth: Theme.componentHeight
    implicitHeight: Theme.componentHeight

    focusPolicy: Qt.NoFocus

    // image
    property url source_top: "qrc:/gfx/compass_top.svg"
    property url source_bottom: "qrc:/gfx/compass_bottom.svg"
    property int sourceSize: UtilsNumber.alignTo(height * 0.8, 2)
    property int sourceRotation: 0

    // settings
    property int radius: width * 0.28
    property string hoverMode: "off" // available: off
    property string highlightMode: "off" // available: off

    // colors
    property string iconColor: Theme.colorIcon
    property string highlightColor: Theme.colorPrimary
    property string borderColor: Theme.colorSeparator
    property string backgroundColor: Theme.colorLowContrast

    ////////////////

    background: Item {
        implicitWidth: Theme.componentHeight
        implicitHeight: Theme.componentHeight

        Rectangle { // background_alpha_borders
            anchors.fill: parent
            anchors.margins: isPhone ? -2 : -3
            radius: control.radius
            color: control.borderColor
            opacity: 0.66

            layer.enabled: true
            layer.effect: MultiEffect {
                autoPaddingEnabled: true
                shadowEnabled: true
                shadowColor: "#66000000"
            }
        }
        Rectangle { // background
            anchors.fill: parent
            radius: control.radius
            color: control.backgroundColor
        }
/*
        RippleThemed {
            anchors.fill: parent
            anchor: control

            clip: visible
            pressed: control.pressed
            active: enabled && (control.down || control.visualFocus || control.hovered)
            color: Qt.rgba(Theme.colorForeground.r, Theme.colorForeground.g, Theme.colorForeground.b, 0.9)
        }
*/
    }

    ////////////////

    contentItem: Item {
        rotation: control.sourceRotation
        Behavior on rotation { RotationAnimation { duration: 333; direction: RotationAnimator.Shortest} }

        IconSvg {
            anchors.centerIn: parent

            width: control.sourceSize
            height: control.sourceSize

            color: Theme.colorRed
            source: control.source_top
        }
        IconSvg {
            anchors.centerIn: parent

            width: control.sourceSize
            height: control.sourceSize

            color: control.iconColor
            source: control.source_bottom
        }
    }

    ////////////////
}
