tool
extends VBoxContainer

export (bool) var set_random_pool setget set_random_pool

func set_random_pool(b):
    randomize()
    var Dicelib = load("engine/dice/dicelib.gd")
    var dicelib = Dicelib.new()
    var dicelist = []
    for i in get_child_count():
        var dice = dicelib.dict.values()[randi()%dicelib.dict.size()]
        dicelist.append(dice)
    set_dicepool(dicelist)

func set_dicepool(dicelist):
    for i in dicelist.size():
        get_child(i).set_dice(dicelist[i])
