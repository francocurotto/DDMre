extends Reference

var ability_buff = 0

# public functions
func get_power(attack, attacked, has_adv, has_disadv):
    """
    Return the power of a monster attacking with attack value, and considering
    if monster has advantage or disadvantage over attacked monster (if 
    attacked monster has neutral ability, ignore advantages and disadvantages).
    """
    var power = attack + ability_buff
    if not attacked.has_active_ability("NEUTRAL"):
        power = apply_adv_disadv(power, has_adv, has_disadv)
    return power
        
func apply_adv_disadv(power, has_adv, has_disadv):
    """
    Apply type advantges and disadvantages.
    """
    return power + int(has_adv)*10 - int(has_disadv)*10

func reset_ability_buff():
    ability_buff = 0
