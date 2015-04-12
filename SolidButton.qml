import QtQuick 2.4

Rectangle {
	id: root

	signal clicked

	function idealTextColor(backgroundColor)
	{
		var nThreshold = 105;
		var bgDelta = (backgroundColor.r * 0.299) + (backgroundColor.g * 0.587) + (backgroundColor.b * 0.114);

		return (255 - bgDelta < nThreshold) ? "black" : "white";
	}

	property alias text: text.text
	property alias enabled: mouseArea.enabled
	property string buttonColor: "#FFFF6E0D"
	property string pressedColor: Qt.darker(buttonColor, 1.1)
	color:
		if (!enabled)
			Qt.lighter(buttonColor, 1.2)
		else
		{
			if (mouseArea.containsMouse)
				pressedColor
			else
				buttonColor
		}
	border.color: buttonColor === "white" ? "black" : "transparent"
	radius: 10

	width: Math.min(text.contentWidth + 10, height * 2.5)

	Text {
		id: text

		anchors.fill: parent

		color: buttonColor === "white" ? "black" : idealTextColor(root.color)
		font {
			pixelSize: height * 0.5
			family: immortalFont.name
		}
		horizontalAlignment: Text.AlignHCenter
		verticalAlignment: Text.AlignVCenter
	}

	MouseArea {
		id: mouseArea

		anchors.fill: parent
		onClicked: root.clicked();
	}
}
