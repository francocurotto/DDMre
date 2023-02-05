extends "base_ability.gd"

# variables
var limit

func _init(ability_dict).(ability_dict):
    limit = ability_dict["LIMIT"]

# public functions
func on_summon(monster, _dungeon):
    monster.turn_move_limit = limit
