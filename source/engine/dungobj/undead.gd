extends "monster.gd"

# constants
const TYPE = "UNDEAD"

# is functions
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
