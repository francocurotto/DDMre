extends Reference

# variables
var name
var dungeon

func _init(ability_info):
    name = ability_info["NAME"]

# public functions
func initialize(_summon, _dungeon):
    dungeon = _dungeon
