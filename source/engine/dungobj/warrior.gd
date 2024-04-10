extends "monster.gd"
## Monster of warrior type.

#region constants
const TYPE = "WARRIOR"
#endregion

#region is functions
## Return true if monster has advantage over monster [param attacked].
func has_adv(attacked):
    return attacked.has_disadv_over_warrior()

## Warrior monsters have disadvantage over beast monsters.
func has_disadv_over_beast():
    return true
#endregion
