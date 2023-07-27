extends "monster.gd"

# constants
const TYPE = "BEAST"

func _init(_card, _player):
    super(_card, _player)
    pass

# is functions
func has_adv(attacked):
    """
    Return true if monster has advantage over attacked monster.
    """
    return attacked.has_disadv_over_beast()

func has_disadv_over_undead():
    """
    Return true if monster has advantage over undead.
    """
    return true
