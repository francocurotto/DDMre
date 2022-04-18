tool
extends PanelContainer

export (bool) var random_pool setget set_random_pool

func _ready():
    set_random_pool(true)

func set_random_pool(_bool):
    randomize()
    var Dicelib = load("engine/dice/dicelib.gd")
    var dicelib = Dicelib.new()
    var dicelist = []
    for i in $TPCont/PoolCont.get_child_count():
        var dice = dicelib.dict.values()[randi()%dicelib.dict.size()]
        dicelist.append(dice)
    set_dicepool(dicelist)

func set_dicepool(dicelist):
    for i in dicelist.size():
        var diceitem = $TPCont/PoolCont.get_child(i)
        diceitem.set_dice(dicelist[i])
        diceitem.set_index(i)
