extends "dimension_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func activate(_activate_dict):
    for monster in dungeon.monsters:
        if monster.is_tunnel():
            monster.die()

# is functions
func is_state_dim():
    return true
