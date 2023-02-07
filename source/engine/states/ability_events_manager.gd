extends Reference

# variables
var player
var opponent
var dungeon

func _init(_player, _opponent, _dungeon):
    player = _player
    opponent = _opponent
    dungeon = _dungeon

# private functions
func on_exodia_activated():
    Events.emit_signal("player_lost", opponent)
