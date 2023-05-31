extends "manual_item_ability.gd"

var AMOUNT

func _init(ability_dict).(ability_dict):
    AMOUNT = ability_dict["AMOUNT"]

# public functions
func activate(monster):
    monster.receive_damage(AMOUNT)
