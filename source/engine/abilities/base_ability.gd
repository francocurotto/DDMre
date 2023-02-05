extends Reference

# variables
var name

func _init(ability_info):
    name = ability_info["NAME"]

# public functions
func on_summon(_summon, _dungeon):
    pass

func activate(_monster, _dungeon):
    pass
