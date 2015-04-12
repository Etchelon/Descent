import QtQuick 2.4
import QtQuick.Window 2.2

Window {
	height: 720
	width: 1280
	visible: true

	FontLoader {
		id: windlassFont
		source: "Windlass.ttf"
	}
	FontLoader {
		id: immortalFont
		source: "IMMORTAL.ttf"
	}

	Rectangle {
		id: monsterTypes

		height: parent.height
		width: parent.width / 2
		anchors.left: parent.left
		property AddBossPopup addBossPopup: null

		function showAddBossPopup(index)
		{
			var component = Qt.createComponent("AddBossPopup.qml")
			if (component.status === Component.Ready)
			{
				addBossPopup = component.createObject(monsterTypeList, { "modal": true, "index": index });
				addBossPopup.show();
			}
			else
				console.log("Status: " + component.status + "; error: " + component.errorString());
		}

		Rectangle {
			id: heading1

			anchors {
				top: parent.top
				left: parent.left
				right: parent.right
			}
			height: parent.height / 8
			z: 1

			color: "black"

			Text {
				anchors.fill: parent

				text: "Tipi di mostri"
				color: "white"
				style: Text.Sunken
				font {
					family: immortalFont.name
					pixelSize: height * 0.75
				}
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter
			}
		}

		ListView {
			id: monsterTypeList

			anchors {
				top: heading1.bottom
				left: parent.left
				right: parent.right
				bottom: parent.bottom
			}

			//snapMode: ListView.SnapToItem
			boundsBehavior: Flickable.StopAtBounds

			model: ListModel {
				ListElement {
					name: "Ala Tagliente"
					whiteHp: 5
					redHp: 6
					image: "Monsters/AlaTagliente.png"
				}
				ListElement {
					name: "Chaos Beast"
					whiteHp: 11
					redHp: 12
					image: "Monsters/ChaosBeast.png"
				}
				ListElement {
					name: "Coboldo"
					whiteHp: 4
					redHp: 5
					image: "Monsters/Coboldo.png"
				}
				ListElement {
					name: "Demone"
					whiteHp: 11
					redHp: 12
					image: "Monsters/Demone.png"
				}
				ListElement {
					name: "Drago"
					whiteHp: 11
					redHp: 12
					image: "Monsters/Drago.png"
				}
				ListElement {
					name: "Elfo Oscuro"
					whiteHp: 7
					redHp: 8
					image: "Monsters/ElfoOscuro.png"
				}
				ListElement {
					name: "Ferrox"
					whiteHp: 5
					redHp: 6
					image: "Monsters/Ferrox.png"
				}
				ListElement {
					name: "Gigante"
					whiteHp: 11
					redHp: 12
					image: "Monsters/Gigante.png"
				}
				ListElement {
					name: "Golem"
					whiteHp: 8
					redHp: 9
					image: "Monsters/Golem.png"
				}
				ListElement {
					name: "Manticora"
					whiteHp: 7
					redHp: 8
					image: "Monsters/Manticora.png"
				}
				ListElement {
					name: "Naga"
					whiteHp: 7
					redHp: 8
					image: "Monsters/Naga.png"
				}
				ListElement {
					name: "Ogre"
					whiteHp: 7
					redHp: 8
					image: "Monsters/Ogre.png"
				}
				ListElement {
					name: "Ragno"
					whiteHp: 4
					redHp: 5
					image: "Monsters/Ragno.png"
				}
				ListElement {
					name: "Sacerdote Oscuro"
					whiteHp: 5
					redHp: 6
					image: "Monsters/SacerdoteOscuro.png"
				}
				ListElement {
					name: "Scheletro"
					whiteHp: 4
					redHp: 5
					image: "Monsters/Scheletro.png"
				}
				ListElement {
					name: "Scimmia"
					whiteHp: 9
					redHp: 10
					image: "Monsters/Scimmia.png"
				}
				ListElement {
					name: "Segugio Infernale"
					whiteHp: 5
					redHp: 6
					image: "Monsters/SegugioInfernale.png"
				}
				ListElement {
					name: "Stregone"
					whiteHp: 5
					redHp: 6
					image: "Monsters/Stregone.png"
				}
				ListElement {
					name: "Troll"
					whiteHp: 9
					redHp: 10
					image: "Monsters/Troll.png"
				}
				ListElement {
					name: "Uomo bestia"
					whiteHp: 4
					redHp: 5
					image: "Monsters/UomoBestia.png"
				}
				ListElement {
					name: "Final Boss"
					isBoss: true
					image: "Monsters/Boss_1.png"
				}
			}

			delegate: BorderImage {
				id: monsterTypeListDelegate

				readonly property bool selected: ListView.view.currentIndex === index

				width: ListView.view.width
				height: ListView.view.height / 4
				source: "Pergamena5.jpg"

				MouseArea {
					anchors.fill: parent
					onClicked: monsterTypeListDelegate.ListView.view.currentIndex = index;
				}

				Image {
					id: im1

					anchors {
						top: parent.top
						topMargin: 20
						bottom: parent.bottom
						bottomMargin: 20
						left: parent.left
						leftMargin: 20
					}
					width: height

					source: image
				}

				Text {
					anchors {
						left: im1.right
						leftMargin: 10
						verticalCenter: parent.verticalCenter
					}

					text: name
					color: "white"
					style: Text.Sunken
					font {
						family: windlassFont.name
						pixelSize: 48
					}
				}

				Item {
					width: parent.height / 3
					visible: !isBoss

					anchors {
						right: parent.right
						rightMargin: 20
						top: parent.top
						topMargin: 20
						bottom: parent.bottom
						bottomMargin: 20
					}

					Rectangle {
						height: parent.width
						width: parent.width
						anchors.top: parent.top

						radius: 10
						color: ma1.containsPress ? "lightgray" : "white"
						visible: monsterTypeListDelegate.selected

						MouseArea {
							id: ma1

							anchors.fill: parent
							onClicked:
							{
								var item = monsterTypeList.model.get(index);
								var newMonster = {
									type: item.name,
									isBoss: false,
									hp: item.whiteHp,
									monsterColor: "white",
									image: item.image
								};
								monsterList.model.append(newMonster);
							}
						}

						Text {
							anchors.centerIn: parent
							text: "+"
							font {
								bold: true
								pixelSize: 36
							}
						}
					}

					Rectangle {
						height: parent.width
						width: parent.width
						anchors.bottom: parent.bottom

						radius: 10
						color: ma2.containsPress ? "darkred" : "red"
						visible: monsterTypeListDelegate.selected

						MouseArea {
							id: ma2

							anchors.fill: parent
							onClicked:
							{
								var item = monsterTypeList.model.get(index);
								var newMonster = {
									type: item.name,
									isBoss: false,
									hp: item.redHp,
									monsterColor: "red",
									image: item.image,
									name: ""
								};
								monsterList.model.append(newMonster);
							}
						}

						Text {
							anchors.centerIn: parent
							text: "+"
							font {
								bold: true
								pixelSize: 36
							}
						}
					}
				}

				Item {
					width: parent.height / 3
					visible: isBoss

					anchors {
						right: parent.right
						rightMargin: 20
						top: parent.top
						topMargin: 20
						bottom: parent.bottom
						bottomMargin: 20
					}

					Rectangle {
						height: parent.width
						width: parent.width
						anchors.verticalCenter: parent.verticalCenter

						radius: 10
						color: ma3.containsPress ? "lightgray" : "white"
						visible: monsterTypeListDelegate.selected

						MouseArea {
							id: ma3

							anchors.fill: parent
							onClicked: monsterTypes.showAddBossPopup(index);
						}

						Text {
							anchors.centerIn: parent
							text: "+"
							font {
								bold: true
								pixelSize: 36
							}
						}
					}
				}
			}
		}

		Rectangle {
			width: 1
			height: parent.height
			z: 2
			anchors {
				right: parent.right
			}
		}
	}

	Rectangle {
		id: monsters

		height: parent.height
		width: parent.width / 2
		anchors.right: parent.right

		function showHpPopup(index)
		{
//			var component = Qt.createComponent("HpPopup.qml")
//			if (component.status === Component.Ready)
//			{
//				hpPopup = component.createObject(monsterList, { "modal": true, "index": index });
//				hpPopup.show();
//			}
//			else
//				console.log("Status: " + component.status + "; error: " + component.errorString());
		}

		Rectangle {
			id: heading2

			anchors {
				top: parent.top
				left: parent.left
				right: parent.right
			}
			height: parent.height / 8
			z: 1

			color: "black"

			Text {
				anchors.fill: parent

				text: "Mostri in gioco"
				color: "white"
				style: Text.Sunken
				font {
					family: immortalFont.name
					pixelSize: height * 0.75
				}
				horizontalAlignment: Text.AlignHCenter
				verticalAlignment: Text.AlignVCenter
			}
		}

		ListView {
			id: monsterList

			anchors {
				top: heading2.bottom
				left: parent.left
				right: parent.right
				bottom: parent.bottom
			}

			snapMode: ListView.SnapToItem
			boundsBehavior: Flickable.StopAtBounds

			model: ListModel { }

			delegate: BorderImage {
				id: monsterListDelegate

				width: ListView.view.width
				height: ListView.view.height / 4

				source: "Pergamena.jpg"

				Column {
					width: parent.width * 0.5
					anchors {
						left: parent.left
						top: parent.top
						topMargin: 10
						bottom: parent.bottom
						bottomMargin: 10
					}
					spacing: 5

					property real itemHeight: (height - spacing) / 2

					Rectangle {
						anchors {
							horizontalCenter: parent.horizontalCenter
						}
						height: parent.itemHeight
						width: height

						color: monsterColor

						Image {
							id: im2

							anchors.centerIn: parent
							height: parent.height - 10
							width: parent.width - 10
							source: image
						}
					}
					Text {
						height: parent.itemHeight
						anchors {
							left: parent.left
							leftMargin: 10
							right: parent.right
							rightMargin: 10
						}

						text: isBoss ? name : type
						color: "white"
						style: Text.Sunken
						horizontalAlignment: Text.AlignHCenter
						verticalAlignment: Text.AlignVCenter
						elide: Text.ElideRight
						font {
							family: windlassFont.name
							pixelSize: 30 * (isBoss ? 1.3 : 1)
						}
					}
				}
				Row {
					width: parent.width * 0.5
					height: parent.height
					anchors {
						right: parent.right
						rightMargin: 10
					}
					spacing: 5

					property real btnWidth: (width - 2*spacing) / 3

					Rectangle {
						anchors {
							verticalCenter: parent.verticalCenter
						}
						width: parent.btnWidth
						height: width

						radius: 20
						color: ma4.containsPress ? "lightgray" : "white"
						border.width: 2

						Text {
							anchors.fill: parent

							text: hp
							verticalAlignment: Text.AlignVCenter
							horizontalAlignment: Text.AlignHCenter
							font.pixelSize: height * 0.5
						}
						MouseArea {
							id: ma4
							anchors.fill: parent
							onClicked: monsters.showHpPopup(index);
						}
					}

					Rectangle {
						anchors {
							verticalCenter: parent.verticalCenter
						}
						width: parent.btnWidth
						height: width

						radius: 20
						color: ma5.containsPress ? "lightgray" : "white"
						border.width: 2

						Text {
							anchors.fill: parent

							text: "-/+"
							verticalAlignment: Text.AlignVCenter
							horizontalAlignment: Text.AlignHCenter
							font {
								bold: true
								pixelSize: height * 0.4
							}
						}
						MouseArea {
							id: ma5
							anchors.fill: parent
							onClicked:
							{
								var list = monsterListDelegate.ListView.view.model;
								var item = list.get(index);
								item.hp -= 1;
								if (item.hp === 0)
									list.remove(index, 1);
							}
							onPressAndHold:
							{
								var list = monsterListDelegate.ListView.view.model;
								var item = list.get(index);
								item.hp += 1;
							}
						}
					}

					Rectangle {
						anchors {
							verticalCenter: parent.verticalCenter
						}
						width: parent.btnWidth
						height: width

						Timer {
							id: resetStatusTimer

							interval: 3000
							repeat: false
							onTriggered: parent.status = 0;
						}

						property int status: 0	// 0: normal, 1: pressed once, next press is confirmation
						function handle_click()
						{
							if (status === 0)
							{
								status = 1;
								resetStatusTimer.start();
							}
							else
							{
								var list = monsterListDelegate.ListView.view.model;
								list.remove(index, 1);
								status = 0;
							}
						}

						radius: 20
						color: status === 1 ? Qt.lighter("red", 1.2) : "white"
						border.width: 2

						Image {
							anchors.centerIn: parent
							height: parent.height / 2
							width: height
							source: "SkullIcon.png"
						}
						MouseArea {
							anchors.fill: parent
							onClicked: parent.handle_click();
						}
					}
				}
			}
		}

		Rectangle {
			width: 1
			height: parent.height
			z: 2
			anchors {
				left: parent.left
			}
		}
	}
}
