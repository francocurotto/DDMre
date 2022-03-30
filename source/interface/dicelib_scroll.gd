extends ScrollContainer

export (PackedScene) var DiceItem

func fill(dicelib):
    for key in dicelib:
        var diceitem = DiceItem.instance()
        diceitem.update_item(dicelib[key])
        var button = Button.new()
        button.text = "ASDF" + str(key)
        #$VBox.add_child(button)
        $VBox.add_child(diceitem)
