extends "dimension_ability.gd"

var cost
var crest

func _init(ability_dict).(ability_dict):
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(_activate_dict):
    monster.player.crestpool.remove_crests(crest, cost)
    for monster in dungeon.monsters:
        if monster.is_tunnel():
            monster.die()

# is functions
func is_dim_state():
    return true
