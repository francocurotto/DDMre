extends "summon.gd"

# constants
const NAME = "ITEM"

func _init(_card, _player).(_card, _player):
    pass

# publlic functions
func activate(monster):
    card.activate(monster)

func destroy():
    """
    Remove item from play due to being destroyed by an ability or activation.
    """
    negate_abilities()
    player.on_item_destroyed(self)

# is functions
func is_item():
    return true
