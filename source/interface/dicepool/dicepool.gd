tool
extends PanelContainer

signal roll_changed

export (bool) var random_pool setget set_random_pool

func _ready():
	if Engine.editor_hint:
		set_random_pool(true)
	for diceitem in $TPCont/PoolCont.get_children():
		diceitem.get_node("Button").connect("pressed", self, "_on_diceitem_pressed")

func set_random_pool(_bool):
	randomize()
	var Dicelib = load("engine/dice/dicelib.gd")
	var dicelib = Dicelib.new()
	var dicelist = []
	for i in $TPCont/PoolCont.get_child_count():
		var dice = dicelib.get_randdice()
		dicelist.append(dice)
	set_dicepool(dicelist)

func set_dicepool(dicelist):
	for i in dicelist.size():
		var diceitem = $TPCont/PoolCont.get_child(i)
		diceitem.set_dice(dicelist[i])
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
			
