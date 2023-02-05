extends "base_ability.gd"

# variables
var amount

func _init(ability_dict).(ability_dict):
    amount = ability_dict["AMOUNT"]

# public functions
func on_summon(monster, _dungeon):
    monster.speed = amount
