extends "continuous_ability.gd"
## STOPTUNNEL ability.
##
## Negate the TUNNEL ability of all tunnel monsters.

#region public functions
## Activate ability. Negate TUNNEL ability of all monsters.
func activate():
    super()
    for monster in dungeon.monsters:
        if monster.has_ability("TUNNEL"):
            monster.get_ability("TUNNEL").negate()

## Deactivate ability. Remove negate of TUNNEL ability of all monsters.
func deactivate():
    super()
    for monster in dungeon.monsters:
        if monster.has_ability("TUNNEL"):
            monster.get_ability("TUNNEL").remove_negate()
#endregion

#region signals callbacks
## When a new summon occurs, if monster has TUNNEL ability, negate ability.
func on_new_summon(_summon, _net):
    if _summon.has_ability("TUNNEL"):
        _summon.get_ability("TUNNEL").negate()
#endregion
