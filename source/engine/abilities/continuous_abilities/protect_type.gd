extends "res://engine/abilities/continuous_ability.gd"

# variables
var type

func _init(ability_dict):
    super(ability_dict)
    type = ability_dict["TYPE"]

# public functions
func activate():
    super.activate()
    #GODTO4: use array filter
    for monster in dungeon.monsters:
        if monster.TYPE == type:
            monster.damage_behavior.add_limit(0)

func deactivate():
    super.deactivate()
    #GODTO4: use array filter
    for monster in dungeon.monsters:
        if monster.TYPE == type:
            monster.damage_behavior.remove_limit(0)

# signals callbacks
func on_new_summon(_summon):
    if _summon.TYPE == type:
        _summon.damage_behavior.add_limit(0)
