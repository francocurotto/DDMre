extends Reference

# public functions
func can_pass(monster):
    """
    Return true if pass behavior allows to pass monster during movement.
    """
    return monster.has_active_ability("FLY")
