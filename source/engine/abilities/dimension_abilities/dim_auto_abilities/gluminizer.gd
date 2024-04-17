extends "dim_auto_ability.gd"
## GLUMINIZER abilty.
##
## Increase the movement cost for all monsters to 2 tiles per crest.

#region public functions
## Activate ability. Increase movement cost and destroy item.
func activate():
    dungeon.move_cost = 2
    summon.destroy()
#endregion
