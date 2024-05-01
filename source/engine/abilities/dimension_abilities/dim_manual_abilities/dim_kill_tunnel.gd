extends "dim_manual_ability.gd"
## DIMKILLTUNNEL ability.
##
## Destroy a monster in dungeon with the ability TUNNEL.

#region variables
var cost  ## Cost to pay to activate abililty
var crest ## Crest type to pay to activate ability
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]
#endregion

#region public functions
## Activate ability using parameters [param activate_dict]. Destroy tunnel
## monster and pay ability cost.
func activate(activate_dict):
    pay_crests(crest, cost)
    var pos = activate_dict["pos"]
    var monster = dungeon.get_tile(pos).content
    monster.destroy()

## Get tiles where ability can be casted.
func get_select_tiles():
    return get_active_ability_monsters_tiles("TUNNEL")
#endregion
