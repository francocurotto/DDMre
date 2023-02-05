extends "base_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func on_summon(monster, _dungeon):
    monster.turn_move_limit = 0
