import QtQuick

import ComponentLibrary

TagButtonImpl {
    property color color: Theme.colorPrimary

    colorBackground: Qt.rgba(color.r, color.g, color.b, 0.2)
    colorBorder: colorBackground
    colorText: color
}
