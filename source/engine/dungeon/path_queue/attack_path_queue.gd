extends "path_queue.gd"

func get_next_tiles(path):
    var path_dest = path[-1]
    tiles = []
    if len(path)<monster.attack_distance and path_dest.is_path():
        for tile in dungeon.get_neighbor_tiles(path_dest):
            if tile.is_path():
                tiles.append(tile)
    return tiles
    
    
