import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.impl
import QtQuick.Templates as T
import Qt.labs.qmlmodels

import ComponentLibrary

T.Popup {
    id: actionMenu

    implicitWidth: parent.width
    implicitHeight: contentColumn.height

    y: appWindow.height

    padding: 0
    margins: 0

    modal: true
    dim: true
    focus: appWindow.isMobile
    closePolicy: T.Popup.CloseOnEscape | T.Popup.CloseOnPressOutside
    parent: T.Overlay.overlay

    property string titleTxt
    property string titleSrc // disabled

    property var model: null

    property int layoutDirection: Qt.LeftToRight // disabled

    signal menuSelected(var index)

    ////////////////

    property int actualHeight: {
        if (typeof mobileMenu !== "undefined" && mobileMenu.height)
            return contentColumn.height + appWindow.screenPaddingNavbar + appWindow.screenPaddingBottom
        return contentColumn.height
    }

    enter: Transition { NumberAnimation { duration: 233; property: "height"; from: 0; to: actionMenu.actualHeight; } }
    exit: Transition { NumberAnimation { duration: 233; property: "height"; from: actionMenu.actualHeight; to: 0; } }

    T.Overlay.modal: Rectangle {
        color: "#000"
        opacity: Theme.isLight ? 0.24 : 0.666
    }

    background: Rectangle {
        color: Theme.colorComponentBackground

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            height: Theme.componentBorderWidth
            color: Theme.colorSeparator
        }
    }

    ////////////////

    contentItem: Item {
        Column {
            id: contentColumn
            anchors.left: parent.left
            anchors.leftMargin: screenPaddingLeft
            anchors.right: parent.right
            anchors.rightMargin: screenPaddingRight

            topPadding: Theme.componentMargin
            bottomPadding: 4
            spacing: 4

            ////

            Text { // title
                anchors.left: parent.left
                anchors.leftMargin: Theme.componentMargin + 4
                anchors.right: parent.right
                anchors.rightMargin: Theme.componentMargin

                height: Theme.componentHeight
                visible: actionMenu.titleTxt

                text: actionMenu.titleTxt
                textFormat: Text.PlainText

                color: Theme.colorSubText
                font.bold: false
                font.pixelSize: Theme.fontSizeContentVeryBig
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            ////

            Repeater {
                model: actionMenu.model
                delegate: DelegateChooser {
                    id: chooser
                    role: "t"
                    DelegateChoice {
                        roleValue: "sep"
                        ActionMenuSeparator {
                            width: actionMenu.width
                        }
                    }
                    DelegateChoice {
                        roleValue: "itm"
                        ActionMenuItem {
                            width: actionMenu.width
                            layoutDirection: actionMenu.layoutDirection
                            index: idx
                            text: txt
                            source: src
                            onClicked: {
                                actionMenu.menuSelected(idx)
                                actionMenu.close()
                            }
                        }
                    }
                }
            }

            ////
        }
    }

    ////////////////
}
