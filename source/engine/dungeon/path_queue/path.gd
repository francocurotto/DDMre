extends Reference

var dungeon
var monster
var tiles

func _init(_dungeon, _monster, _tiles=null):
    dungeon = _dungeon
    monster = _monster
    if _tiles == null:
        tiles = [monster.tiles]
    else:
        tiles = _tiles

# public functions
func get_new_path(max_tiles):
    var new_paths = []
    if len(tiles) < max_tiles and is_passable():
        for tile in dungeon.get_neighour_tiles(monster.tile):
            if is_reachable(tile):
                var new_path = create_new_path(tile)
                new_paths.append(new_path)

# is functions
func is_passable():
    pass

func is_reachable(tile):
    pass
