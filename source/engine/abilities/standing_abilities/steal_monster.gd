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
    Steal monster.
    """
    monster.player.crestpool.remove_crests(crest, cost)
    var opponent_monster = dungeon.get_tile(activate_dict["pos"]).content
    opponent_monster.switch_player()
    monster.die()

func get_select_tiles():
    return get_opponent_monsters_tiles()
