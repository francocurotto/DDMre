extends "power_behavior_base.gd"

# public functions
func apply_adv_disadv(power, _has_adv, _has_disadv):
    """
    As neutral ability, do not apply advantages or disadvantages.
    """
    return power
