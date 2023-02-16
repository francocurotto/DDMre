extends "res://engine/abilities2/manual_item_ability.gd"

# variables
var crest
var amount

func _init(ability_dict).(ability_dict):
    crest = ability_dict["CREST"]
    amount = ability_dict["AMOUNT"]

# public functions
func activate(monster):
    monster.player.crestpool.remove_crests(crest, amount)
