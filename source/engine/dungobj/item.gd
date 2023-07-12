extends "summon.gd"

# constants
const TYPE = "ITEM"

func _init(_card, _player).(_card, _player):
    pass

# public functions
func activate(monster):
    card.activate(monster)

func destroy():
    """
    Remove item from play due to being destroyed by an ability or activation.
    """
    negate_abilities()
    tile.empty_tile()

# is functions
func is_item():
    return true
