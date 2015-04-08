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
		property var addMonsterPopup: null

		function showAddMonsterPopup(index)
		{
			var component = Qt.createComponent("AddMonsterPopup.qml")
			if (component.status === Component.Ready)
			{
				addMonsterPopup = component.createObject(monsters, { "modal": true, "index": index });
				addMonsterPopup.show();
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

			Rectangle {
				width: 1
				height: parent.height
				anchors {
					right: parent.right
				}
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

			snapMode: ListView.SnapToItem

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

				Rectangle {
					height: parent.height / 3
					width: height
					anchors {
						right: parent.right
						rightMargin: 20
						top: parent.top
						topMargin: 20
					}

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
					height: parent.height / 3
					width: height
					anchors {
						right: parent.right
						rightMargin: 20
						bottom: parent.bottom
						bottomMargin: 20
					}

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
								hp: item.redHp,
								monsterColor: "red",
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
			}
		}
	}

	Rectangle {
		id: monsters

		height: parent.height
		width: parent.width / 2
		anchors.right: parent.right
		property HpPopup hpPopup: null

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

			Rectangle {
				width: 1
				height: parent.height
				anchors {
					left: parent.left
				}
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

						text: type
						color: "white"
						style: Text.Sunken
						horizontalAlignment: Text.AlignHCenter
						verticalAlignment: Text.AlignVCenter
						elide: Text.ElideRight
						font {
							family: windlassFont.name
							pixelSize: 30
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
						color: ma3.containsPress ? "lightgray" : "white"
						border.width: 2

						Text {
							anchors.fill: parent

							text: hp
							verticalAlignment: Text.AlignVCenter
							horizontalAlignment: Text.AlignHCenter
							font.pixelSize: height * 0.5
						}
						MouseArea {
							id: ma3
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
						color: ma4.containsPress ? "lightgray" : "white"
						border.width: 2

						Text {
							anchors.fill: parent

							text: "-"
							verticalAlignment: Text.AlignVCenter
							horizontalAlignment: Text.AlignHCenter
							font {
								bold: true
								pixelSize: height * 0.5
							}
						}
						MouseArea {
							id: ma4
							anchors.fill: parent
							onClicked:
							{
								var list = monsterListDelegate.ListView.view.model;
								var item = list.get(index);
								item.hp -= 1;
								if (item.hp === 0)
									list.remove(index, 1);
							}
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

						Image {
							anchors.centerIn: parent
							height: parent.height / 2
							width: height
							source: "SkullIcon.png"
						}
						MouseArea {
							id: ma5
							anchors.fill: parent
							onClicked:
							{
								var list = monsterListDelegate.ListView.view.model;
								list.remove(index, 1);
							}
						}
					}
				}
			}
		}
	}
}
