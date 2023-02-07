extends "base_ability.gd"

var amount

func _init(ability_dict).(ability_dict):
    amount = ability_dict["AMOUNT"]

# public functions
func item_activate(monster):
    monster.restore_health(amount)
