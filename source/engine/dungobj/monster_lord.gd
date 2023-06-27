extends "playerobj.gd"

# constants
const NAME = "MONSTER_LORD"
const LIMIT = 3

# variables
var hearts = 3

func _init(_player).(_player):
    pass

# set functions
func set_hearts(amount):
    """
    Set number of hearts in monster lord. Correct for hearts outside limits.
    """
    # check for lower limit of zero
    amount = max(0, amount)
    # check for upper limit of 3
    amount = min(LIMIT, amount)
    # set hearts
    hearts = amount
    # check for player lost
    if hearts <= 0:
        player.on_hearts_depleted()

# public functions
func receive_damage():
    set_hearts(hearts-1)

# is functions
func is_monster_lord():
    return true
