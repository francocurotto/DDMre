extends "path_queue.gd"

# constants
const MovePath = preload("move_path.gd")

# setget functions
func get_max_tiles():
    var move_crests = monster.player.crestpool.movement
    return min(int(move_crests/dungeon.move_cost)*monster.speed, monster.max_move)

# private functions
func init_paths():
    paths = [MovePath.new(monster.tile)]
