extends "monster.gd"
## Monster of spellcaster type.

#region constants
const TYPE = "SPELLCASTER"
#endregion

#region is functions
## Return true if monster has advantage over monster [param attacked].
func has_adv(attacked):
    return attacked.has_disadv_over_spellcaster()

## Spellcaster monsters have disadvantage over dragon.
func has_disadv_over_dragon():
    return true
#endregion
