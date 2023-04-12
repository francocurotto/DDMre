extends "standing_ability.gd"

# variables
var cost
var crest
var opponent_monster

func _init(ability_dict).(ability_dict):
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    """
    Mind control.
    """
    monster.player.crestpool.remove_crests(crest, cost)
    opponent_monster = dungeon.get_tile(activate_dict["pos"]).content
    opponent_monster.switch_player()
    Events.connect("next_turn", self, "on_next_turn")

func get_select_tiles():
    return get_opponent_monsters_tiles()

# signals
func on_next_turn(_player, _turn):
    opponent_monster.switch_player()
    Events.disconnect("next_turn", self, "on_next_turn")
