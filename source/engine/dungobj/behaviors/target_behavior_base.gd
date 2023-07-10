extends Reference

# public functions
func can_target_monster(opponent_monster):
    """
    Return true if opponent monster can be targeted for an attack.
    """
    return not opponent_monster.has_active_ability("FLY")
