extends "standing_ability.gd"

# variables
var attr
var cost
var crest

func _init(ability_dict).(ability_dict):
    attr = ability_dict["ATTR"]
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(_dungeon, _activate_dict):
    """
    Buff monster attr by damage.
    """
    monster.player.crestpool.remove_crests(crest, cost)
    var damage = monster.card.health - monster.health
    monster.buff_attr(attr.to_lower(), damage)
