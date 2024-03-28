import QtQuick
import QtQuick.Controls

import ThemeEngine

Flickable {
    contentWidth: -1
    contentHeight: contentColumn.height

    boundsBehavior: isDesktop ? Flickable.OvershootBounds : Flickable.DragAndOvershootBounds
    ScrollBar.vertical: ScrollBar { visible: false }

    Column {
        id: contentColumn

        anchors.left: parent.left
        anchors.right: parent.right

        topPadding: Theme.componentMarginXL
        bottomPadding: Theme.componentMarginXL
        spacing: Theme.componentMarginXL

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Progress bars")
            source: ""
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            ProgressBarThemed {
                anchors.left: parent.left
                anchors.right: parent.right

                value: 0.5
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Data bars")
            source: ""
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            DataBarCompact {
                anchors.left: parent.left
                anchors.right: parent.right

                value: 33

                legend: ""
                prefix: ""
                suffix: " cm"
                colorForeground: Theme.colorBlue
            }

            DataBarSolid {
                anchors.left: parent.left
                anchors.right: parent.right

                value: 66

                legend: ""
                prefix: ""
                suffix: "°"
                colorForeground: Theme.colorRed
            }
        }

        ListTitle { ////////////////////////////////////////////////////////////
            anchors.leftMargin: singleColumn ? 0 : Theme.componentMargin
            anchors.rightMargin: singleColumn ? 0 : Theme.componentMargin

            text: qsTr("Other indicators")
            source: ""
        }

        Column {
            anchors.left: parent.left
            anchors.leftMargin: Theme.componentMarginXL
            anchors.right: parent.right
            anchors.rightMargin: Theme.componentMarginXL
            spacing: Theme.componentMarginXL

            Row {
                spacing: Theme.componentMarginXL

                ProgressArc {
                    width: 128
                    value: 0.33
                }
                ProgressArc {
                    width: 128
                    value: 0.66
                    arcCap: "round"
                    arcColor: Theme.colorMaterialLime
                }
            }

            Row {
                spacing: Theme.componentMarginXL

                ProgressCircle {
                    width: 128
                    value: 0.33
                    arcColor: Theme.colorMaterialDeepOrange
                }
                ProgressCircle {
                    width: 128
                    value: 0.66
                    isPie: true
                }
            }
        }
    }
}
