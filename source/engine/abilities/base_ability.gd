extends Reference

# variables
var name
var negate_count = 0

func _init(ability_info):
    name = ability_info["NAME"]

# public functions
func on_summon(_summon, _dungeon):
    pass

func activate(_monster, _dungeon):
    pass

func negate(_summon, _dungeon):
    negate_count += 1
