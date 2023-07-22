extends "res://engine/abilities/reply_ability.gd"

# variables
var cost
var crest

func _init(ability_dict).(ability_dict):
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(_attacker, activate_dict):
    """
    Add temporal limit to damage behavior.
    """
    .activate(_attacker, activate_dict)
    pay_crests(crest, cost)
    var receiver = dungeon.get_tile(activate_dict["pos"]).content
    summon.damage_behavior.receiver = receiver

func deactivate():
    .deactivate()
    summon.damage_behavior.receiver = summon

func get_select_tiles():
    return get_player_other_monsters_tiles()
