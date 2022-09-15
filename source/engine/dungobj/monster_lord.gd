extends "playerobj.gd"

# constants
const NAME = "MONSTER_LORD"

# variables
var hearts = 3

# signals
signal hearts_depleted

func _init(_player).(_player):
    pass

# public functions
func receive_damage():
    hearts -= 1
    if hearts <= 0:
        emit_signal("hearts_depleted")

# is functions
func is_monster_lord():
    return true
