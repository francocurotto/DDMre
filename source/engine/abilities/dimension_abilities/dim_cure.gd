extends "dimension_ability.gd"

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
    monster.player.crestpool.remove_crests(crest, cost)
    for pos in activate_dict["poslist"]:
        var selected_monster = dungeon.get_tile(pos).content
        selected_monster.restore_health(amount)

# is functions
func is_dim_state():
    return true
