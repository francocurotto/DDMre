extends "monster.gd"

# constants
const TYPE = "SPELLCASTER"

func _init(_card, _player):
    super(_card, _player)
    pass

# is functions
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
