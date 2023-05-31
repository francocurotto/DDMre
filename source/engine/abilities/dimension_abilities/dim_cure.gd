extends "dimension_ability.gd"

# variables
var AMOUNT
var NUMBER
var COST
var CREST

func _init(ability_dict).(ability_dict):
    AMOUNT = ability_dict["AMOUNT"]
    NUMBER = ability_dict["NUMBER"]
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    monster.player.crestpool.remove_crests(CREST, COST)
    for pos in activate_dict["poslist"]:
        var selected_monster = dungeon.get_tile(pos).content
        selected_monster.restore_health(AMOUNT)

func get_select_tiles():
    return get_player_other_monsters_tiles()

# is functions
func is_dim_state():
    return true
