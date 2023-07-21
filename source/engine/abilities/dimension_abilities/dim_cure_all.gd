extends "res://engine/abilities/dim_auto_ability.gd"

# variables
var AMOUNT

func _init(ability_dict).(ability_dict):
    AMOUNT = ability_dict["AMOUNT"]

# public functions
func activate():
    for monster in summon.player.monsters:
        monster.restore_health(AMOUNT)
