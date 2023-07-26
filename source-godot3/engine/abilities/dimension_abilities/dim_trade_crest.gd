extends "res://engine/abilities/dim_manual_ability.gd"

var cost
var amount

func _init(ability_dict).(ability_dict):
    cost = ability_dict["COST"]
    amount = ability_dict["AMOUNT"]

# public functions
func activate(activate_dict):
    pay_crests(activate_dict["pay_crest"], cost)
    gain_crests(activate_dict["gain_crest"], amount)
