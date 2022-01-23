//
//    M I S T Y      M O U N T A I N
//                     an sddm theme
//
// This theme is free software, menaing that you can redistribute it
// and/or modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation.
//
// You are required to preserve this and any additional legal notices
// either contained in this repository or on any future version of the
// GNU General Public License.
//
// This software is distributed WITHOUT ANY WARRANTY !!!!!!!!!!!!!!!!
// See the GNU General Public License for more details at the following
// site <https://www.gnu.org/licenses/>
//

// Import what's needed
import QtQuick 2.11
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.12
import SddmComponents 2.0
import "components"

Rectangle {

  // Main Container
  id: container
  width: 1920
  height: 1080
  LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
  LayoutMirroring.childrenInherit: true
  property int sessionIndex: session.index

  // Inherited from SDDMComponents
  TextConstants {
    id: textConstants
  }

  // Set SDDM actions
  Connections {
    target: sddm

    onLoginSucceeded: {}

    onLoginFailed: {
      error_message.color = "#bf616a"
      txtMessage.text = textConstants.loginFailed
      listView.currentItem.password = ""
    }
  }

  // Set Font
  FontLoader {
    id: textFont; name: config.displayFont
  }

  // Background Fill
  Rectangle {
    anchors.fill: parent
    color: "#2e3440"
  }

  // Background IMage
  Image {
    id: image1
    anchors.fill: parent
    source: config.backgroundImage
    fillMode: Image.PreserveAspectCrop
  }

  // Clock and Login Area
  Rectangle {
    id: rectangle
    anchors.fill: parent
    color: "transparent"

    Clock {
      id: clock
      y: parent.height * config.relativePositionY - clock.height / 2
      x: parent.width * config.relativePositionX - clock.width / 2
      color: "#eceff4"
      timeFont.family: config.timeFont
      dateFont.family: config.timeFont
      spacing: 0

      Label {
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: config.HeaderText !=="" ? root.font.pointSize * 3 : 0
        color: root.palette.text
        renderType: Text.QtRendering
        text: config.HeaderText
      }

      Label {
        id: timeLabel
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: root.font.pointSize * 3
        color: root.palette.text
        renderType: Text.QtRendering
        function updateTime() {
          text = new Date().toLocaleTimeString(Qt.locale(config.Locale), config.HourFormat == "long" ? Locale.LongFormat : config.HourFormat !== "" ? config.HourFormat : Locale.ShortFormat)
        }
      }
      Label {
        id: dateLabel
        anchors.horizontalCenter: parent.horizontalCenter
        color: root.palette.text
        renderType: Text.QtRendering
        function updateTime() {
          text = new Date().toLocaleDateString(Qt.locale(config.Locale), config.DateFormat == "short" ? Locale.ShortFormat : config.DateFormat !== "" ? config.DateFormat : Locale.LongFormat)
        }
      }

      Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
          dateLabel.updateTime()
          timeLabel.updateTime()
        }
      }

      Component.onCompleted: {
        dateLabel.updateTime()
        timeLabel.updateTime()
      }
    }

    // User Login
    Rectangle {
      id: login_container
      y: clock.y + clock.height + 30
      width: clock.width
      height: parent.height * 0.08
      color: "transparent"
      anchors.left: clock.left

      Rectangle {
        id: username_row
        height: parent.height * 0.42
        color: "transparent"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        transformOrigin: Item.Center
        anchors.margins: 10

        Text {
          id: username_label
          width: parent.width * 0.32
          height: parent.height * 0.66
          horizontalAlignment: Text.AlignLeft
          font.family: config.displayFont
          font.bold: true
          font.pixelSize: 18
          color: "#ECEFF4"
          text: "Username"
          anchors.verticalCenter: parent.verticalCenter
        }

        TextBox {
          id: username_input_box
          height: parent.height
          text: userModel.lastUser
          anchors.verticalCenter: parent.verticalCenter
          anchors.left: username_label.right
          anchors.leftMargin: config.usernameLeftMargin
          anchors.right: parent.right
          anchors.rightMargin: 0
          font: config.displayFont
          color: "#25000000"
          borderColor: "transparent"
          textColor: "#ECEFF4"

          Keys.onPressed: {
            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
              sddm.login(username_input_box.text, password_input_box.text, session.index)
              event.accepted = true
            }
          }
          KeyNavigation.backtab: password_input_box
          KeyNavigation.tab: password_input_box
        }
      }

      Rectangle {
        id: password_row
        y: username_row.height + 10
        height: parent.height * 0.45
        color: "transparent"
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0

        Text {
          id: password_label
          width: parent.width * 0.32
          text: textConstants.password
          anchors.verticalCenter: parent.verticalCenter
          horizontalAlignment: Text.AlignLeft
          font.family: config.displayFont
          font.bold: true
          font.pixelSize: 18
          color: "#ECEFF4"
        }

        PasswordBox {
          id: password_input_box
          height: parent.height
          font: config.displayFont
          color: "#25000000"
          anchors.verticalCenter: parent.verticalCenter
          anchors.right: parent.right
          anchors.rightMargin: parent.height
          anchors.left: password_label.right
          anchors.leftMargin: config.passwordLeftMargin
          borderColor: "transparent"
          textColor: "#ECEFF4"
          tooltipBG: "#25000000"
          tooltipFG: "#bf616a"
          image: "components/warning.svg"

          onTextChanged: {
            if (password_input_box.text == "") {
              clear_passwd_button.visible = false
            }
            if (password_input_box.text != "" && config.showClearPasswordButton != "false") {
              clear_passwd_button.visible = true
            }
          }

          Keys.onPressed: {
            if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
              sddm.login(username_input_box.text, password_input_box.text, session.index)
              event.accepted = true
            }
          }

          KeyNavigation.backtab: username_input_box
          KeyNavigation.tab: login_button
        }

        Button {
          id: clear_passwd_button
          height: parent.height
          width: parent.height
          color: "transparent"
          text: "x"
          font: config.displayFont
          border.color: "transparent"
          border.width: 0
          anchors.verticalCenter: parent.verticalCenter
          anchors.right: parent.right
          anchors.leftMargin: 0
          anchors.rightMargin: parent.height
          disabledColor: "#bf616a"
          activeColor: "#4c566a"
          pressedColor: "#a3be8c"

          onClicked: {
            password_input_box.text=''
            password_input_box.focus = true
          }
        }

        Button {
          id: login_button
          height: parent.height
          color: "#2e3440"
          text: ">"
          border.color: "#00000000"
          anchors.verticalCenter: parent.verticalCenter
          anchors.left: password_input_box.right
          anchors.right: parent.right
          disabledColor: "#bf616a"
          activeColor: "#5e81ac"
          pressedColor: "#a3be8c"
          textColor: "white"
          font: config.displayFont
          onClicked: sddm.login(username_input_box.text, password_input_box.text, session.index)
          KeyNavigation.backtab: password_input_box
          KeyNavigation.tab: reboot_button
        }

        Text {
          id: error_message
          height: parent.height
          font.family: config.displayFont
          font.pixelSize: 14
          color: "white"
          anchors.top: password_input_box.bottom
          anchors.left: password_input_box.left
          anchors.leftMargin: 0
        }
      }
    }
  }

  // Top Bar
  Rectangle {
    id: actionBar
    width: parent.width
    height: parent.height * 0.04
    anchors.top: parent.top;
    anchors.horizontalCenter: parent.horizontalCenter
    color: "#25000000"
    visible: config.showTopBar != "false"

    Row {
      id: row_left
      anchors.left: parent.left
      anchors.margins: 5
      height: parent.height
      spacing: 10

      ComboBox {
        id: session
        width: 160
        height: 36
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"
        arrowColor: "transparent"
        textColor: "#2e3440"
        font.pixelSize: 18
        borderColor: "transparent"
        hoverColor: "transparent"
        model: sessionModel
        index: sessionModel.lastIndex
        KeyNavigation.backtab: shutdown_button
        KeyNavigation.tab: password_input_box
      }

      ComboBox {
        id: language
        model: keyboard.layouts
        index: keyboard.currentLayout
        width: 60
        height: 36
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"
        arrowColor: "transparent"
        textColor: "#2e3440"
        font.pixelSize: 24
        borderColor: "transparent"
        hoverColor: "transparent"
        onValueChanged: keyboard.currentLayout = id

        Connections {
          target: keyboard
          onCurrentLayoutChanged: combo.index = keyboard.currentLayout
        }

        rowDelegate: Rectangle {
          color: "transparent"

          Text {
            anchors.margins: 4
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            verticalAlignment: Text.AlignVCenter
            text: modelItem ? modelItem.modelData.shortName : "zz"
            font.family: config.displayFont
            font.pixelSize: 18
            color: "#2e3440"
          }
        }

        KeyNavigation.backtab: session
        KeyNavigation.tab: username_input_box
      }
    }

    Row {
      id: row_right
      height: parent.height
      anchors.right: parent.right
      anchors.margins: 5
      spacing: 10

      ImageButton {
        id: reboot_button
        height: parent.height
        source: "components/restart.svg"
        visible: sddm.canReboot
        onClicked: sddm.reboot()
        KeyNavigation.backtab: login_button
        KeyNavigation.tab: suspend_button
      }

      ImageButton {
        id: suspend_button
        height: parent.height
        source: "components/suspend.svg"
        onClicked: sddm.suspend()
        enabled: sddm.canSuspend
        KeyNavigation.backtab: reboot_button
        KeyNavigation.tab: shutdown_button
      }

      ImageButton {
        id: shutdown_button
        height: parent.height
        source: "components/shutdown.svg"
        visible: sddm.canPowerOff
        onClicked: sddm.powerOff()
        KeyNavigation.backtab: suspend_button
        KeyNavigation.tab: session
      }
    }
  }

  Component.onCompleted: {
    // Set Focus
    if (username_input_box.text == "")
    username_input_box.focus = true
    else
    password_input_box.focus = true

    if (config.showLoginButton == "false") {
      login_button.visible = false
      password_input_box.anchors.rightMargin = 0
      clear_passwd_button.anchors.rightMargin = 0
    }

    clear_passwd_button.visible = false
  }
}
