extends "state.gd"

# constants
const NAME = "DIMENSION"

# variables
var dim_candidates
var DungeonState = load("engine/states/dungeon_state.gd")

func _init(_player, _opponent, _dungeon, _dim_candidates).(_player, _opponent, _dungeon):
    dim_candidates = _dim_candidates

func SKIP(_cmd):
    """
    Execute the SKIP command.
    """
    return DungeonState.new(player, opponent, dungeon)
