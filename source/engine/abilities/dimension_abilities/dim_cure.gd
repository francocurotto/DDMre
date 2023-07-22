extends "res://engine/abilities/dim_manual_ability.gd"

# variables
var amount
var number
var cost
var crest

func _init(ability_dict).(ability_dict):
    amount = ability_dict["AMOUNT"]
    number = ability_dict["NUMBER"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    pay_crests(crest, cost)
    for pos in activate_dict["poslist"]:
        var monster = dungeon.get_tile(pos).content
        monster.restore_health(amount)

func get_select_tiles():
    return get_player_other_monsters_tiles()
