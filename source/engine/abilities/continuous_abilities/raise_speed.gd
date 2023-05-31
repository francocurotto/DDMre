extends "continuous_ability.gd"

# variables
var AMOUNT

func _init(ability_dict).(ability_dict):
    AMOUNT = ability_dict["AMOUNT"]

# public functions
func on_dimension():
    monster.speed = AMOUNT

func disable():
    .disable()
    monster.speed = 1
