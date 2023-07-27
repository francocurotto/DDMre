extends "res://engine/abilities/continuous_ability.gd"

# variables
var amount

func _init(ability_dict):
    super(ability_dict)
    amount = ability_dict["AMOUNT"]

# public functions
func activate():
    summon.speed = amount

func deactivate():
    summon.speed = 1
