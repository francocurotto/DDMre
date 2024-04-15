extends "res://engine/abilities/monster_abilities/monster_ability.gd"

# constants
const TYPE = "CAST"

func _init(ability_dict):
    super(ability_dict)
    pass

# is functions
func is_cast():
    return true
