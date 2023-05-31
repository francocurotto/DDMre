extends "dimension_ability.gd"

# variables
var CREST
var AMOUNT

func _init(ability_dict).(ability_dict):
    CREST = ability_dict["CREST"]
    AMOUNT = ability_dict["AMOUNT"]

# public functions
func on_dimension():
    monster.player.crestpool.add_crests(CREST, AMOUNT)
