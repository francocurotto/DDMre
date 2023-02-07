extends "base_ability.gd"

var attr
var amount

func _init(ability_dict).(ability_dict):
    attr = ability_dict["ATTR"]
    amount = ability_dict["AMOUNT"]

# public functions
func item_activate(monster):
    monster.buff_attr(attr.to_lower(), amount)
