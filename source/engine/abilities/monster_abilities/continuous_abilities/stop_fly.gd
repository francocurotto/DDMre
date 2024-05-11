extends "continuous_ability.gd"
## STOPFLY ability.
##
## Negate the FLY ability of all flying monsters.

#region public functions
## Activate ability. Negate FLY ability of all monsters.
func activate():
    super()
    for monster in dungeon.monsters:
        if monster.has_ability("FLY"):
            monster.get_ability("FLY").negate()

## Deactivate ability. Remove negate of FLY ability of all monsters.
func deactivate():
    super()
    for monster in dungeon.monsters:
        if monster.has_ability("FLY"):
            monster.get_ability("FLY").remove_negate()
#endregion

#region signals callbacks
## When a new summon occurs, if monster has FLY ability, negate ability.
func on_new_summon(_summon):
    if _summon.has_ability("FLY"):
        _summon.get_ability("FLY").negate()
#endregion
