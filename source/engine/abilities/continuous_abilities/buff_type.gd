extends "res://engine/abilities/continuous_ability.gd"

# variables
var type
var attr
var amount

func _init(ability_dict):
    super(ability_dict)
    type = ability_dict["TYPE"]
    attr = ability_dict["ATTR"]
    amount = ability_dict["AMOUNT"]

# public functions
func activate():
    super.activate()
    #GODOT4: use array filter
    for monster in dungeon.monsters:
        if monster.TYPE == type:
            monster.buff_attr(attr, amount)

func deactivate():
    super.deactivate()
    #GODOT4: use array filter
    for monster in dungeon.monsters:
        if monster.TYPE == type:
            monster.debuff_attr(attr, amount)

# signals callbacks
func on_new_summon(_summon, _net):
    if _summon.TYPE == type:
        _summon.buff_attr(attr, amount)
