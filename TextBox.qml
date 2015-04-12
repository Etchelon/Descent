import QtQuick 2.4
import QtQuick.Controls 1.3

Item {
	id: root

	property alias label: label.text
	property alias text: textField.text
	property alias placeholder: textField.placeholderText
	property alias textField: textField

	implicitHeight: label.implicitHeight + textField.implicitHeight + 10 // TODO: fix this magic number

	Label {
		id: label

		anchors {
			horizontalCenter: parent.horizontalCenter
			top: parent.top
			topMargin: 15
		}

		text: "Label"
		font.family: immortalFont.name
	}
	TextField {
		id: textField

		width: parent.width * 0.9
		anchors {
			horizontalCenter: parent.horizontalCenter
			top: label.bottom
			topMargin: 15
		}

		placeholderText: ""
	}
}
