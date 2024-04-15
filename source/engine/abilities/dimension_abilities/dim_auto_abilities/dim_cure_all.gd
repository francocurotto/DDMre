extends "res://engine/abilities/dim_auto_ability.gd"

# variables
var amount

func _init(ability_dict):
    super(ability_dict)
    amount = ability_dict["AMOUNT"]

# public functions
func activate():
    for monster in summon.player.monsters:
        monster.restore_health(amount)
