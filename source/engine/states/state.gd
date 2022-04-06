extends Reference

var player
var opponent
var cmdlist = []

func _init(stateplayer, stateopponent):
	player = stateplayer
	opponent = stateopponent

func update(cmd):
	"""
	Update state given command cmd.
	"""
	call(cmd["name"], cmd)
