extends "res://engine/abilities/ability.gd"
## Ability that belongs to a monster.
##
## Monster abilities can be negated, that is, other abilities can disable the
## effects of these abilities. Monster abilities are sub-divided in four types:
## continuous abilities, cast abilities, attack abilities, and reply abilities.

#region variables
var negate_count = 0 ## Counter for number of negations in ability
#endregion

#region public functions
## Negate ability, increase negate counter.
func negate():
    negate_count += 1

## Remove negate, decrease negate counter.
func remove_negate():
    negate_count -= 1
#endregion

#region is functions
## Return true if ability is negated, that is, the negate count is over zero.
func is_negated():
    return negate_count > 0
#endregion
