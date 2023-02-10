extends Reference

# public functions
func get_power(attack, attacked, has_adv, has_disadv):
    """
    Return the power of a monster attacking with attack value, and considering
    if monster has advantage or disadvantage over attacked monster (if 
    attacked monster has neutral ability, ignore advantages and disadvantages).
    """
    if attacked.has_active_ability("NEUTRAL"):
        return attack
    else:
        return attack + int(has_adv)*10 - int(has_disadv)*10
