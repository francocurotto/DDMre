extends "summon.gd"

# constants
const NAME = "ITEM"

func _init(_card, _player).(_card, _player):
    pass

# publlic functions
func activate(monster, dungeon):
    card.activate(monster, dungeon)

func die():
    """
    Remove item from play due to being a dimension item.
    """
    player.on_item_dead(self)

# is functions
func is_item():
    return true
