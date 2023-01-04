extends Reference

# variables
var slots = []

func _init(ability_list):
    for ability_info in ability_list:
        slots.append(create_ability(ability_info))

# is functions
func empty():
    """
    Return true if ability list is empty.
    """
    return slots.empty()

# private functions
const Tunneling = preload("res://engine/abilities/tunneling.gd")
const Fly = preload("res://engine/abilities/fly.gd")
const Archer = preload("res://engine/abilities/archer.gd")
const Neutral = preload("res://engine/abilities/neutral.gd")
const NoAbility = preload("res://engine/abilities/no_ability.gd")
func create_ability(ability_info):
    """
    Creates ability object from ability info dict.
    """
    match ability_info["NAME"]:
        "TUNNELING" : return Tunneling.new(ability_info)
        "FLY"       : return Fly.new(ability_info)
        "ARCHER"    : return Archer.new(ability_info)
        "NEUTRAL"   : return Neutral.new(ability_info)
        _           : return NoAbility.new()
