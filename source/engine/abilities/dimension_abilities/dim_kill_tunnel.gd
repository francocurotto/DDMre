extends "dimension_ability.gd"

var cost
var crest

func _init(ability_dict).(ability_dict):
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    monster.player.crestpool.remove_crests(crest, cost)
    var tunnel_monster = dungeon.get_tile(activate_dict["pos"]).content
    tunnel_monster.die()

func get_select_tiles():
    var tiles = []
    for monster in dungeon.monsters:
        if monster.is_tunnel():
            tiles.append(monster.tile)
    return tiles

# is functions
func is_dim_state():
    return true
