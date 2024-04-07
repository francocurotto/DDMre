extends "playerobj.gd"

# constants
const TYPE = "MONSTER_LORD"
const LIMIT = 3

# variables
var hearts = 3

func _init(_player):
    super(_player)
    pass

# set functions
func set_hearts(amount):
    """
    Set number of hearts in monster lord. Correct for hearts outside limits.
    """
    # clamp amount between limits
    amount = clamp(amount, 0 , LIMIT)
    # set hearts
    hearts = amount
    # check for player lost
    if hearts <= 0:
        Events.player_lost.emit(player)

# public functions
func receive_damage():
    set_hearts(hearts-1)

# is functions
func is_monster_lord():
    return true
