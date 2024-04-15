extends "res://engine/abilities/standing_ability.gd"

# variables
var amount
var cost
var crest

func _init(ability_dict):
    super(ability_dict)
    amount = ability_dict["AMOUNT"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    pay_crests(crest, cost)
    var pos = activate_dict["pos"]
    var monster = dungeon.get_tile(pos).content
    monster.receive_damage(amount)
    summon.receive_damage(amount)

func get_select_tiles():
    return get_opponent_monsters_tiles()
