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

		BorderImage {
			visible: shown && !widthAnimation.running
			anchors.fill: parent
			source: "Pergamena4.jpg"

			Rectangle {
				id: header

				width: parent.width
				height: 80
				anchors {
					top: parent.top
					horizontalCenter: parent.horizontalCenter
				}

				color: "black"

				Text {
					anchors.fill: parent

					wrapMode: Text.Wrap
					text: "Final Boss info"
					font {
						pixelSize: 48
						family: immortalFont.name
					}
					color: "white"
					horizontalAlignment: Text.AlignHCenter
					verticalAlignment: Text.AlignVCenter
				}
			}

			Column {
				id: column

				width: parent.width * 0.75
				anchors {
					top: header.bottom
					horizontalCenter: parent.horizontalCenter
				}

				spacing: 30

				TextBox {
					id: nameTbox

					width: parent.width
					label: "Boss name"
				}

				TextBox {
					id: hpTbox

					width: parent.width
					label: "Boss Hit Points"
				}
			}

			Row {
				id: imagePicker

				width: column.width
				anchors {
					top: column.bottom
					topMargin: 30
					horizontalCenter: column.horizontalCenter
				}

				spacing: 10
				property real imageWidth: (width - 2*spacing)/3
				property int selectedIndex: 0

				Rectangle {
					width: parent.imageWidth
					height: width
					property bool selected: imagePicker.selectedIndex === 1
					color: selected ? "dodgerblue" : "transparent"

					MouseArea {
						anchors.fill: parent
						onClicked: imagePicker.selectedIndex = 1;
					}

					Image {
						id: bossIm1
						anchors {
							fill: parent
							margins: 3
						}
						source: "Monsters/Boss_1.png"
					}
				}

				Rectangle {
					width: parent.imageWidth
					height: width
					property bool selected: imagePicker.selectedIndex === 2
					color: selected ? "dodgerblue" : "transparent"

					MouseArea {
						anchors.fill: parent
						onClicked: imagePicker.selectedIndex = 2;
					}

					Image {
						id: bossIm2
						anchors {
							fill: parent
							margins: 3
						}
						source: "Monsters/Boss_2.png"
					}
				}

				Rectangle {
					width: parent.imageWidth
					height: width
					property bool selected: imagePicker.selectedIndex === 3
					color: selected ? "dodgerblue" : "transparent"

					MouseArea {
						anchors.fill: parent
						onClicked: imagePicker.selectedIndex = 3;
					}

					Image {
						id: bossIm3
						anchors {
							fill: parent
							margins: 3
						}
						source: "Monsters/Boss_3.png"
					}
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

					buttonColor: "black"
					text: "Ok"
					onClicked:
					{
						var item = monsterTypeList.model.get(root.index);
						var newBoss = {
							type: item.name,
							isBoss: true,
							monsterColor: "gold",
							hp: parseInt(hpTbox.text),
							name: nameTbox.text,
							image: "Monsters/Boss_" + (imagePicker.selectedIndex || 1) + ".png"
						};
						monsterList.model.append(newBoss);
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
