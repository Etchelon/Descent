import QtQuick 2.4

Item {
	id: root

	property bool modal: false
	property int index
	property bool shown: false

	readonly property int animationDuration: 300
	Timer {
		id: selfDestroy

		interval: animationDuration
		triggeredOnStart: false

		onTriggered: root.destroy();
	}

	function show()
	{
		box.width = parent.width * 0.75;
		box.height = parent.height * 0.75;
	}

	function hide()
	{
		box.width = 0;
		box.height = 0;
		selfDestroy.start();
	}

	anchors.fill: parent

	Rectangle {
		id: shade

		anchors.fill: parent
		color: "black"
		opacity: 0.5
		visible: root.modal
		z: box.z - 1

		MouseArea {
			id: touchWell
			anchors.fill: parent

			onClicked: console.log("Touch well, makes the popup modal");
		}
	}

	Rectangle {
		id: box

		anchors.centerIn: parent
		Behavior on width {
			NumberAnimation {
				id: widthAnimation

				duration: animationDuration
				easing.type: Easing.InOutBack
				easing.overshoot: 1.5

				onRunningChanged: root.shown = box.width > 0;
			}
		}

		Behavior on height {
			NumberAnimation {
				duration: animationDuration
				easing.type: Easing.InOutBack
				easing.overshoot: 1.5
			}
		}

		z: 1000

		color: "white"

		Item {
			visible: shown && !widthAnimation.running
			anchors.fill: parent

			Text {
				id: text

				width: parent.width * 0.75
				anchors.top: parent.top
				anchors.topMargin: 20
				anchors.horizontalCenter: parent.horizontalCenter

				color: "black"
				wrapMode: Text.Wrap
				text: "Add or subtract hp"
				font.pixelSize: 30
				horizontalAlignment: Text.AlignHCenter
			}

			Row {
				width: parent.width * 0.75
				height: width / 1.5
				anchors {
					top: text.bottom
					topMargin: 20
					horizontalCenter: parent.horizontalCenter
				}

				spacing: 20

				Rectangle {
					id: negative

					property bool active: true
					property bool enabled: true

					width: parent.width / 2 - parent.spacing / 2
					height: parent.height
					color: enabled ? "dodgerblue" : Qt.lighter("dodgerblue", 1.4)
					Behavior on color {
						ColorAnimation { duration: 200 }
					}

					Text {
						anchors.centerIn: parent

						text: negative.active ? "-" : "+"
						color: "white"
						font.pixelSize: negative.height * 0.9
					}

					MouseArea {
						anchors.fill: parent
						enabled: negative.enabled
						onClicked: negative.active = !negative.active;
					}
				}

				Spinner {
					id: hpSpinner

					width: parent.width / 2 - parent.spacing / 2
					height: parent.height
					value: 4
				}

				Binding {
					target: negative
					property: "active"
					value: false
					when: hpSpinner.value == 0
				}

				Binding {
					target: negative
					property: "enabled"
					value: true
					when: hpSpinner.value != 0
				}

				Binding {
					target: negative
					property: "enabled"
					value: false
					when: hpSpinner.value == 0
				}
			}

			Row {
				id: buttons

				anchors {
					bottom: parent.bottom
					bottomMargin: 20
					horizontalCenter: parent.horizontalCenter
				}
				height: 50

				spacing: 10

				SolidButton {
					id: rateBtn

					height: parent.height
					width: cancelBtn.width

					text: "Ok"
					onClicked:
					{
						var item = monsterList.model.get(root.index);
						console.log("Item: " + item);
						item.hp += (negative.active ? -1 : 1) * hpSpinner.value;
						root.hide();
					}
				}

				SolidButton {
					id: cancelBtn

					height: parent.height

					buttonColor: "white"
					text: "Cancel"
					onClicked: root.hide();
				}
			}
		}
	}
}
