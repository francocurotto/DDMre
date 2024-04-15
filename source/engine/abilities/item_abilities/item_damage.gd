extends "item_ability.gd"

var amount

func _init(ability_dict):
    super(ability_dict)
    amount = ability_dict["AMOUNT"]

# public functions
func activate(monster):
    monster.receive_damage(amount)
