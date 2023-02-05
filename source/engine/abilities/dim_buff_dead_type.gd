extends "base_ability.gd"

# variables
var type

func _init(ability_dict).(ability_dict):
    type = ability_dict["TYPE"]

# public functions
func on_summon(monster, _dungeon):
    AbilityEvents.emit_signal("dim_buff_dead_type_activated", monster, type)
