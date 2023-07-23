extends "res://engine/abilities/standing_ability.gd"

# variables
var cost
var crest

func _init(ability_dict).(ability_dict):
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    pay_crests(crest, cost)
    var pos = activate_dict["pos"]
    var monster = dungeon.get_tile(pos).content
    # negate abilities
    monster.negate_abilities()
    # negate attack
    monster.attack_cooldown_behavior.max_attacks = 0

func get_select_tiles():
    return get_monsters_tiles()
