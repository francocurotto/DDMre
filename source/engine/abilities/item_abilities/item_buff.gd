extends "res://engine/abilities/item_ability.gd"

# variables
var ATTR
var AMOUNT

func _init(ability_dict).(ability_dict):
    ATTR = ability_dict["ATTR"]
    AMOUNT = ability_dict["AMOUNT"]

# public functions
func activate(monster):
    monster.buff_attr(ATTR.to_lower(), AMOUNT)
