tool
extends PanelContainer

export (bool) var random_pool setget set_random_pool
export (String, "test1", "test2") var pool setget set_dicepool_tool

var dicepool

signal roll_changed

func _ready():
    for diceitem in $TPCont/PoolCont.get_children():
        diceitem.get_node("Button").connect("pressed", self, "_on_diceitem_pressed")
    if Engine.editor_hint:
        set_random_pool(true)

func set_dicepool(_dicepool):
    dicepool = _dicepool
    set_diceitems()

func set_diceitems():
    for i in range(dicepool.size()):
        var diceitem = $TPCont/PoolCont.get_child(i)
        diceitem.set_dice(dicepool[i])
        diceitem.set_index(i)

func _on_diceitem_pressed():
    emit_signal("roll_changed")
    if get_nselected() >= 3:
        disable_unselected()
    else:
        enable_unused()

func get_nselected():
    var n = 0
    for diceitem in $TPCont/PoolCont.get_children():
        n += int(diceitem.selected)
    return n

func disable_unselected():
    for diceitem in $TPCont/PoolCont.get_children():
        diceitem.disable_unselected()

func enable_unused():
    for diceitem in $TPCont/PoolCont.get_children():
        diceitem.enable_unused()

func roll_ready():
    return get_nselected() >= 3

func get_indeces():
    var indeces = []
    for i in $TPCont/PoolCont.get_child_count():
        var diceitem = $TPCont/PoolCont.get_child(i)
        if diceitem.selected:
            indeces.append(i)
    return indeces
            
func set_random_pool(_bool):
    randomize()
    var Dicelib = load("engine/dice/dicelib.gd")
    var dicelib = Dicelib.new()
    var dicelist = dicelib.create_randpool()
    set_dicepool(dicelist)

func set_dicepool_tool(poolname):
    var Dicelib = load("engine/dice/dicelib.gd")
    var dicelib = Dicelib.new()
    var dicelist = dicelib.create_dicepool("res://dicepools/" + poolname + ".json")
    set_dicepool(dicelist)

