extends "standing_ability.gd"

# variables
var attr
var cost
var crest
var amount

func _init(ability_dict).(ability_dict):
    attr = ability_dict["ATTR"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]
    amount = ability_dict["AMOUNT"]

# public functions
func activate(_dungeon, _activate_dict):
    """
    Buff monster attr by amount.
    """
    monster.player.crestpool.remove_crests(crest, cost)
    monster.buff_attr(attr.to_lower(), amount)
