extends Reference

# public functions
func get_power(attack, _attacked, _has_adv, _has_disadv):
    """
    Return the power of a monster attacking with attack value, ignoring 
    advantages and disadvantages.
    """
    return attack
