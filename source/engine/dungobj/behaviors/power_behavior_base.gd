extends RefCounted
## Monster behavior to compute the attack power when attacking a monster.
##
## Normally, attack power is computed with the monster attack attribute, adding
## monster types advantages between attacker and attacked. Some monsters have
## abilities that can temporally buff attack power when attacking.

#region variables
var monster ## attacking monster
var ability_buff = 0 ## temporal ability buffs during attack
#endregion

#region builtin function
func _init(_monster):
    monster = _monster
#endregion

#region public functions
## Get the attack power when attacking monster [param attacked]. Add ability
## buffs to monster power. Additionaly, add monster type advantages, only if 
## attacked monster does not have the active ability "NEUTRAL". 
func get_power(attacked):
    var power = monster.attack + ability_buff
    if not attacked.has_active_ability("NEUTRAL"):
        power += get_adv_buff(attacked)
    return power
#endregion
 
#region private functions
## Compute buff or debuff from monster and [param attacked] type advantage or 
## disadvantage. If attacker have advantage over [param attacked], the buff is 
## 10, if attacker has disadvantage, the debuff is -10, in any other case, the 
## buff is 0.
func get_adv_buff(attacked):
    if monster.has_adv(attacked):
        return 10
    elif monster.has_disav(attacked):
        return -10
    return 0
#endregion
