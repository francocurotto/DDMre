extends "item_ability.gd"

func _init(ability_dict):
    super(ability_dict)
    pass

# public functions
func activate(monster):
    monster.previous_tile.move_content_from(monster.tile)
