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
    Range level kill.
    """
    var monster = dungeon.get_tile(activate_dict["pos"]).content
    var total_cost = cost + monster.card.level
    monster.player.crestpool.remove_crests(crest, total_cost)
    monster.die()

func get_select_tiles():
    return get_opponent_monsters_tiles()
