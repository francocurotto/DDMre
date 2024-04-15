extends "res://engine/abilities/standing_ability.gd"

# variables
var tile_range
var cost
var crest

func _init(ability_dict):
    super(ability_dict)
    tile_range = ability_dict["RANGE"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    var pos = activate_dict["pos"]
    var kill_summon = dungeon.get_tile(pos).content
    var total_cost = cost + kill_summon.card.level
    pay_crests(crest, total_cost)
    kill_summon.destroy()

func get_select_tiles():
    return get_range_opponent_summon_tiles(tile_range)
