extends "base_ability.gd"

# variables
var type
var attr
var amount

func _init(ability_dict).(ability_dict):
    type = ability_dict["TYPE"]
    attr = ability_dict["ATTR"]
    amount = ability_dict["AMOUNT"]

# public functions
func on_summon(_monster, dungeon):
    for tile in dungeon.tiles:
        var dungobj = tile.content
        if dungobj.NAME == type:
            dungobj.buff_attr(attr.to_lower(), amount)
