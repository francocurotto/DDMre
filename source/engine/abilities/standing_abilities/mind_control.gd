extends "res://engine/abilities/standing_ability.gd"

# variables
var cost
var crest
var monster

func _init(ability_dict):
    super(ability_dict)
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    Events.connect("next_turn", Callable(self, "on_next_turn"))
    pay_crests(crest, cost)
    var pos = activate_dict["pos"]
    monster = dungeon.get_tile(pos).content
    monster.switch_player()

func get_select_tiles():
    return get_opponent_monsters_tiles()

# signals callbacks
func on_next_turn(_player, _turn):
    Events.disconnect("next_turn", Callable(self, "on_next_turn"))
    monster.switch_player()
