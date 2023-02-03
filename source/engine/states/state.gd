extends Reference

# preloads
const AbilityEventsManager = preload("res://engine/states/ability_events_manager.gd")

# variables
var player
var opponent
var dungeon
var ability_events_manager

func _init(_player, _opponent, _dungeon):
    player = _player
    opponent = _opponent
    dungeon = _dungeon
    ability_events_manager = AbilityEventsManager.new(player, opponent, dungeon)

# public functions
func update(cmd):
    """
    Update state given command cmd.
    """
    return call(cmd["name"], cmd)
