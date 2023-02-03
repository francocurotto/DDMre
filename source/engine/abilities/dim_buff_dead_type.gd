extends "base_ability.gd"

# variables
var type

func _init(ability_dict).(ability_dict):
    type = ability_dict["TYPE"]

# public functions
func on_summon(_monster):
    pass
