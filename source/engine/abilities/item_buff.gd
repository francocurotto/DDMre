extends "base_ability.gd"

var attr
var amount

func _init(ability_dict).(ability_dict):
    attr = ability_dict["ATTR"]
    amount = ability_dict["AMOUNT"]

# public functions
func activate(monster, _dungeon):
    var buffed_amount = monster.get(attr.to_lower()) + amount
    monster.set(attr.to_lower(), buffed_amount)
