extends "res://engine/abilities/reply_ability.gd"

# variables
var COST
var CREST

func _init(ability_dict).(ability_dict):
    COST = ability_dict["COST"]
    CREST = ability_dict["CREST"]

# public functions
func activate(_attacker, activate_dict):
    """
    Add temporal limit to damage behavior.
    """
    .activate(_attacker, activate_dict)
    pay_crests(CREST, COST)
    var receiver = dungeon.get_tile(activate_dict["pos"]).content
    summon.damage_behavior.receiver = receiver

func deactivate():
    .deactivate()
    summon.damage_behavior.receiver = summon

func get_select_tiles():
    return get_player_other_monsters_tiles()
