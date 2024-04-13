extends "power_behavior_base.gd"
## Monster behavior to compute the attack power from a neutral monster.
##
## For neutral monsters, type advantages and disadvantages does not apply.

#region public functions
## For monsters with neutral ability, advantage buff is 0.
func get_adv_buff(_attacked):
    return 0
#endregion
