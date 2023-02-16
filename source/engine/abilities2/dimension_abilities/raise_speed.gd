extends "res://engine/abilities2/dimension_ability.gd"

# variables
var amount

func _init(ability_dict).(ability_dict):
    amount = ability_dict["AMOUNT"]

# public functions
func on_dimension():
    monster.speed = amount
