extends "item_ability.gd"
## BLACKHOKE ability.
##
## Destroy all summons in dungeon.


#region public functions
## Activate ability. Destroy all summons.
func activate(_monster):
    for _summon in dungeon.summons:
        _summon.destroy()
#endregion
