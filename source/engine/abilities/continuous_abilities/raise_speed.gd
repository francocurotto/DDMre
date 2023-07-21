extends "res://engine/abilities/continuous_ability.gd"

# variables
var AMOUNT

func _init(ability_dict).(ability_dict):
    AMOUNT = ability_dict["AMOUNT"]

# public functions
func activate():
    summon.speed = AMOUNT

func deactivate():
    summon.speed = 1
