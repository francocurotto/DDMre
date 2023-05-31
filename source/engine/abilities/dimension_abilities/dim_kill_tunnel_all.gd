extends "dimension_ability.gd"

var COST
var CREST

func _init(ability_dict).(ability_dict):
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(_activate_dict):
    monster.player.crestpool.remove_crests(CREST, COST)
    for dungeon_monster in dungeon.monsters:
        if dungeon_monster.is_tunnel():
            dungeon_monster.die()

# is functions
func is_dim_state():
    return true
