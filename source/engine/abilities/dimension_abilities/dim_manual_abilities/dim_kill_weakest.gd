extends "dim_manual_ability.gd"
## DIMKILLWEAKEST ability.
##
## Destroy a monster in the dungeon that has the lowest attack value.

#region public functions
## Activate ability using parameters [param activate_dict]. Destroy monster
## with lowest attack.
func activate(activate_dict):
    var pos = activate_dict["pos"]
    var monster = dungeon.get_tile(pos).content
    monster.destroy()

## Get tiles where ability can be casted.
func get_select_tiles():
    return get_weakest_monsters_tiles()
#endregion

