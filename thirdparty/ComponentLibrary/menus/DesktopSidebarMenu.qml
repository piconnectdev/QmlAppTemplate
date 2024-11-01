import QtQuick

import ComponentLibrary

ButtonImpl {
    id: sidebarMenu

    anchors.left: parent.left
    anchors.right: parent.right

    height: Theme.componentHeightXL

    layoutAlignment: Qt.AlignLeft

    leftPadding: 16
    rightPadding: 16
    spacing: 12

    text: sidebarMenu.text
    font.bold: checked

    source: "qrc:/assets/icons/material-symbols/hardware/smartphone-fill.svg"
    sourceSize: 20

    property color color: checked ? Theme.colorPrimary : Theme.colorSidebarContent
    colorBackground: Qt.rgba(color.r, color.g, color.b, checked ? 0.2 : 0.04)
    colorHighlight: checked ? Theme.colorPrimary : Theme.colorSidebarContent
    colorBorder: colorBackground
    colorText: checked ? Theme.colorPrimary : Theme.colorText
    flat: true
}
