extends "dim_manual_ability.gd"
## DIMKILLTUNNELALL ability.
##
## Destroy all monsters in dungeon with the ability TUNNEL.

#region variables
var cost  ## Amount of crests to pay as cost
var crest ## Crest type to pay as cost
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]
#endregion

#region public functions
## Activate ability. Destroy all tunnel monsters and pay ability cost.
func activate(_activate_dict):
    pay_crests(crest, cost)
    for monster in dungeon.monsters:
        if monster.has_active_ability("TUNNEL"):
            monster.destroy()
#endregion
