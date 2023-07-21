extends "res://engine/abilities/standing_ability.gd"

# variables
var COST
var CREST

func _init(ability_dict).(ability_dict):
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    """
    Steal monster.
    """
    pay_crests(CREST, COST)
    var monster = dungeon.get_tile(activate_dict["pos"]).content
    monster.switch_player()
    var tile = summon.tile
    summon.destroy()
    tile.move_content_from(monster.tile)

func get_select_tiles():
    return get_opponent_monsters_tiles()
