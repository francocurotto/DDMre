extends "standing_ability.gd"

# variables
var AMOUNT
var COST
var CREST

func _init(ability_dict).(ability_dict):
    AMOUNT = ability_dict["AMOUNT"]
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    """
    Trade health with opponent monster in pos.
    """
    monster.player.crestpool.remove_crests(CREST, COST)
    var opponent_monster = dungeon.get_tile(activate_dict["pos"]).content
    opponent_monster.receive_damage(AMOUNT)
    monster.receive_damage(AMOUNT)

func get_select_tiles():
    return get_opponent_monsters_tiles()
