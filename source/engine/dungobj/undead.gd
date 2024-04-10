extends "monster.gd"
## Monster of undead type.

#region constants
const TYPE = "UNDEAD"
#endregion

#region is functions
## Return true if monster has advantage over monster [param attacked].
func has_adv(attacked):
    return attacked.has_disadv_over_undead()

## Undead monster have disadvantage over spellcaster monsters.
func has_disadv_over_spellcaster():
    return true
#endregion
