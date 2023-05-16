extends "dimension_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func activate(activate_dict):
    var weakest_monster = dungeon.get_tile(activate_dict["pos"]).content
    weakest_monster.die()

func get_select_tiles():
    var tiles = []
    
    # get a copy of the monsters without the casting monster
    var monsters = dungeon.monsters.duplicate()
    monsters.erase(monster)
    
    for monster in monsters:
        if tiles.empty():
            tiles.append(monster.tile)
        elif tiles[0].content.attack == monster.attack:
            tiles.append(monster.tile)
        elif tiles[0].content.attack > monster.attack:
            tiles = [monster.tile]
    return tiles

# is functions
func is_dim_state():
    return true
