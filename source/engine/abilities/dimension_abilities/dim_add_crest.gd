extends "dimension_ability.gd"

# variables
var crest
var amount

func _init(ability_dict).(ability_dict):
    crest = ability_dict["CREST"]
    amount = ability_dict["AMOUNT"]

# public functions
func on_dimension():
    monster.player.crestpool.add_crests(crest, amount)
