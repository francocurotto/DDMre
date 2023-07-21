extends "res://engine/abilities/dim_auto_ability.gd"

# variables
var CREST
var AMOUNT

func _init(ability_dict).(ability_dict):
    CREST = ability_dict["CREST"]
    AMOUNT = ability_dict["AMOUNT"]

# public functions
func activate():
    gain_crests(CREST, AMOUNT)
