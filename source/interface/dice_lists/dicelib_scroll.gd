extends ScrollContainer

export (PackedScene) var DiceItem

func fill(dicelib):
	for key in dicelib:
		var diceitem = DiceItem.instance()
		diceitem.update_item(dicelib[key])
		$VBox.add_child(diceitem)
