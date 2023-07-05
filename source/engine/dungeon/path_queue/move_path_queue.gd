extends "path_queue.gd"

func get_next_tiles(path):
    var path_dest = path[-1]
    tiles = []
    if len(path)<dungeon.get_max_move_tiles(monster) and path_dest.is_passable():
        for tile in dungeon.get_neighbor_tiles(path_dest):
            if tile.is_reachable():
                tiles.append(tile)
    return tiles
    
    
