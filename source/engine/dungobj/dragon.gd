extends "monster.gd"
## Monster of type dragon.

#region constants
const TYPE = "DRAGON"
#endregion

#region is functions
## Return true if monster has advantage over monster [param attacked].
func has_adv(attacked):
    return attacked.has_disadv_over_dragon()

## Dragon monsters have disadvantage over warrior monsters.
func has_disadv_over_warrior():
    return true
#endregion
