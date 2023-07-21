extends "res://engine/abilities/dim_manual_ability.gd"

var COST
var CREST

func _init(ability_dict).(ability_dict):
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(_activate_dict):
    pay_crests(CREST, COST)
    for monster in dungeon.monsters:
        if monster.has_active_ability("TUNNEL"):
            monster.destroy()
