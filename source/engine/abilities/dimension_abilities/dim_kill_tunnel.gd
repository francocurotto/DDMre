extends "res://engine/abilities/dim_manual_ability.gd"

var cost
var crest

func _init(ability_dict):
    super(ability_dict)
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    pay_crests(crest, cost)
    var pos = activate_dict["pos"]
    var monster = dungeon.get_tile(pos).content
    monster.destroy()

func get_select_tiles():
    return get_active_ability_monsters_tiles("TUNNEL")
