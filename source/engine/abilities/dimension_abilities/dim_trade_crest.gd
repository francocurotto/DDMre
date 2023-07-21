extends "res://engine/abilities/dim_manual_ability.gd"

var COST
var AMOUNT

func _init(ability_dict).(ability_dict):
    COST = ability_dict["COST"]
    AMOUNT = ability_dict["AMOUNT"]

# public functions
func activate(activate_dict):
    summon.player.crestpool.remove_crests(activate_dict["pay_crest"], COST)
    summon.player.crestpool.add_crests(activate_dict["gain_crest"], AMOUNT)
