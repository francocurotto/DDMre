extends "base_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func item_activate(monster):
    monster.previous_tile.move_content_from(monster.tile)
