extends "base_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func item_activate(monster):
    var tile1 = dungeon.get_tile(dungeon.get_dungobj_pos(monster))
    var tile2 = dungeon.get_tile(monster.last_pos)
    tile2.move_content_from(tile1)
