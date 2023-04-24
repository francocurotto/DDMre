extends "dimension_ability.gd"

var cost
var amount

func _init(ability_dict).(ability_dict):
    cost = ability_dict["COST"]
    amount = ability_dict["AMOUNT"]

# public functions
func activate(activate_dict):
    monster.player.crestpool.remove_crests(activate_dict["pay_crest"], cost)
    monster.player.crestpool.add_crests(activate_dict["gain_crest"], amount)

# is functions
func is_state_dim():
    return true
