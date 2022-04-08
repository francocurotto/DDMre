extends Reference

var player
var opponent
var cmdlist = []

func _init(_player, _opponent):
	player = _player
	opponent = _opponent

func update(cmd):
	"""
	Update state given command cmd.
	"""
	call(cmd["name"], cmd)
