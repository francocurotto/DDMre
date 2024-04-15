extends "res://engine/abilities/reply_ability.gd"

# variables
var cost
var crest

func _init(ability_dict):
    super(ability_dict)
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(_attacker, activate_dict):
    """
    Add temporal limit to damage behavior.
    """
    super.activate(_attacker, activate_dict)
    pay_crests(crest, cost)
    var pos = activate_dict["pos"]
    var receiver = dungeon.get_tile(pos).content
    summon.damage_behavior.receiver = receiver

func deactivate():
    super.deactivate()
    summon.damage_behavior.receiver = summon

func get_select_tiles():
    return get_player_other_monsters_tiles()
