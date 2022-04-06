extends VBoxContainer

export (PackedScene) var DiceItem

func fill(dicelist):
	for i in dicelist.size():
		var diceitem = DiceItem.instance()
		diceitem.update_item(dicelist[i])
		diceitem.update_index(i+1)
		add_child(diceitem)
		diceitem.get_node("Button").connect("pressed", self, "_on_diceitem_pressed")

func _on_diceitem_pressed():
	print("Dice item pressed!")
