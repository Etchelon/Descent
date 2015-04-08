import QtQuick 2.4

Rectangle {
	id: root

	property alias value: list.currentIndex

	Rectangle {
		anchors.fill: parent
		color: "dodgerblue"

		ListView {
			id: list

			anchors.fill: parent
			highlightRangeMode: ListView.StrictlyEnforceRange
			clip: true
			model: 16
			delegate: Text {
				height: ListView.view.height
				font.pixelSize: list.height * 0.6;
				color: "white"
				text: index;
				verticalAlignment: Text.AlignVCenter
				anchors.horizontalCenter: parent.horizontalCenter
			}
		}
	}
}
