extends "standing_ability.gd"

# variables
var cost
var crest

func _init(ability_dict).(ability_dict):
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    """
    Kill block.
    """
    monster.player.crestpool.remove_crests(crest, cost)
    dungeon.place_empty_tile(activate_dict["pos"])

func get_select_tiles():
    return get_block_tiles()
