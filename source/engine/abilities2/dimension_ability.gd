extends "monster_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func initialize(_monster, _dungeon):
    .initialize(_monster, _dungeon)
    on_dimension()
