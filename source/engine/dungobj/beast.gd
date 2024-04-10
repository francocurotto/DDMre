extends "monster.gd"
## Monster of beast type.

#region constants
const TYPE = "BEAST"
#endregion

#region is functions
## Return true if monster has advantage over monster [param attacked].
func has_adv(attacked):
    return attacked.has_disadv_over_beast()

## Beast monsters have disadvantage over undead monsters.
func has_disadv_over_undead():
    return true
#endregion
