extends "monster.gd"

# constants
const TYPE = "DRAGON"

func _init(_card, _player).(_card, _player):
    pass

# is functions
func has_adv(attacked):
    """
    Return true if monster has advantage over attacked monster.
    """
    return attacked.has_disadv_over_dragon()

func has_disadv_over_warrior():
    """
    Return true if monster has advantage over warrior.
    """
    return true
