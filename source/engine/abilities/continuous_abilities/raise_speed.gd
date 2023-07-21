extends "res://engine/abilities/continuous_ability.gd"

# variables
var AMOUNT

func _init(ability_dict).(ability_dict):
    AMOUNT = ability_dict["AMOUNT"]

# public functions
func on_dimension():
    summon.speed = AMOUNT

func disable():
    .disable()
    summon.speed = 1
