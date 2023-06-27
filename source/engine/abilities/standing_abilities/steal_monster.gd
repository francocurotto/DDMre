extends "standing_ability.gd"

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
    monster.player.crestpool.remove_crests(CREST, COST)
    var opponent_monster = dungeon.get_tile(activate_dict["pos"]).content
    opponent_monster.switch_player()
    var tile = monster.tile
    monster.destroy()
    tile.move_content_from(opponent_monster.tile)

func get_select_tiles():
    return get_opponent_monsters_tiles()
