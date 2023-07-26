extends "summon.gd"

# constants
const TYPE = "ITEM"

func _init(_card, _player).(_card, _player):
    pass

# public functions
func activate(monster):
    card.activate(monster)

# is functions
func is_item():
    return true
