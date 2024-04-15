extends "cast_ability.gd"

# variables
var cost
var crest

func _init(ability_dict):
    super(ability_dict)
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    """
    Kill block.
    """
    pay_crests(crest, cost)
    var pos = activate_dict["pos"]
    dungeon.place_open_tile(pos)

func get_select_tiles():
    return get_block_tiles()
