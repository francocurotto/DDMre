extends "monster.gd"

# constants
const NAME = "UNDEAD"

func _init(_card, _player).(_card, _player):
    pass

# public functions
func has_adv(attacked):
    """
    Return true if monster has advantage over attacked monster.
    """
    return attacked.has_disadv_over_undead()

func has_disadv_over_spellcaster():
    """
    Return true if monster has advantage over spellcaster.
    """
    return true
