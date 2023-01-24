extends "monster.gd"

# constants
const NAME = "SPELLCASTER"

func _init(_card, _player).(_card, _player):
    pass

# public functions
func has_adv(attacked):
    """
    Return true if monster has advantage over attacked monster.
    """
    return attacked.has_disadv_over_spellcaster()

func has_disadv_over_dragon():
    """
    Return true if monster has advantage over dragon.
    """
    return true
