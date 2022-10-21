tool
extends HBoxContainer

# export variables
export (bool) var roll_dice setget set_random_roll

# setget functions
func set_roll(roll):
    for i in roll.size():
        get_child(i).set_side(roll[i])

func show_roll(_bool):
    modulate = Color(1,1,1,_bool)

func set_random_roll(_bool):
    randomize()
    for sideitem in get_children():
        var randcrest = Globals.CRESTS[randi() % Globals.CRESTS.size()]
        var randmult = randi() % 9 + 1
        sideitem.set_crest(randcrest)
        sideitem.set_mult(randmult)
