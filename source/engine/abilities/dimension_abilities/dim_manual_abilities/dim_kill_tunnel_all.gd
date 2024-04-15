extends "dim_manual_ability.gd"

var cost
var crest

func _init(ability_dict):
    super(ability_dict)
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(_activate_dict):
    pay_crests(crest, cost)
    #GODOT4: use array map
    for monster in dungeon.monsters:
        if monster.has_active_ability("TUNNEL"):
            monster.destroy()
