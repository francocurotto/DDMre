extends "item_ability.gd"

# variables
var attr
var amount

func _init(ability_dict):
    super(ability_dict)
    attr = ability_dict["ATTR"]
    amount = ability_dict["AMOUNT"]

# public functions
func activate(monster):
    monster.buff_attr(attr, amount)
