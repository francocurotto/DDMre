extends "standing_ability.gd"

# variables
var amount
var cost
var crest

func _init(ability_dict).(ability_dict):
    amount = ability_dict["AMOUNT"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    """
    Trade health with opponent monster in pos.
    """
    monster.player.crestpool.remove_crests(crest, cost)
    var opponent_monster = dungeon.get_tile(activate_dict["pos"]).content
    opponent_monster.receive_damage(amount)
    monster.receive_damage(amount)

func get_select_tiles():
    return get_opponent_monsters_tiles()
