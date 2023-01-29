extends "summon.gd"

# constants
const NAME = "ITEM"

func _init(_card, _player).(_card, _player):
    pass

# publlic functions
func activate(monster, dungeon):
    card.activate(monster, dungeon)

# is functions
func is_item():
    return true
