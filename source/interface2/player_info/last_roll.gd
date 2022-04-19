tool
extends HBoxContainer

export (bool) var roll_dice setget set_random_roll

func set_random_roll(_bool):
	randomize()
	for sideitem in get_children():
		var randcrest = Globals.CRESTS[randi() % Globals.CRESTS.size()]
		var randmult = randi() % 9 + 1
		sideitem.set_crest(randcrest)
		sideitem.set_mult(randmult)

func set_roll(roll):
	for i in roll.size():
		get_child(i).set_side(roll[i])
