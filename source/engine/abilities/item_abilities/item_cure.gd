extends "res://engine/abilities/item_ability.gd"

var amount

func _init(ability_dict):
    super(ability_dict)
    amount = ability_dict["AMOUNT"]

# public functions
func activate(monster):
    monster.restore_health(amount)
