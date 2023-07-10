extends "dimension_ability.gd"

var COST
var CREST

func _init(ability_dict).(ability_dict):
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    monster.player.crestpool.remove_crests(CREST, COST)
    var tunnel_monster = dungeon.get_tile(activate_dict["pos"]).content
    tunnel_monster.destroy()

func get_select_tiles():
    var tiles = []
    for monster in dungeon.monsters:
        if monster.has_active_ability("TUNNEL"):
            tiles.append(monster.tile)
    return tiles

# is functions
func is_dim_state():
    return true
