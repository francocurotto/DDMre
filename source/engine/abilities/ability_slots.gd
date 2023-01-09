extends Reference

# variables
var slots = []
var length setget , get_length
var slot1 setget , get_slot1
var slot2 setget , get_slot2

func _init(ability_list):
    for ability_info in ability_list:
        slots.append(create_ability(ability_info))

# setget functions
func get_length():
    return len(slots)

func get_slot1():
    return slots[0]

func get_slot2():
    return slots[1]

# private functions
const Tunneling = preload("res://engine/abilities/tunneling.gd")
const Fly = preload("res://engine/abilities/fly.gd")
const Archer = preload("res://engine/abilities/archer.gd")
const Neutral = preload("res://engine/abilities/neutral.gd")
const BaseAbility = preload("res://engine/abilities/base_ability.gd")
func create_ability(ability_info):
    """
    Creates ability object from ability info dict.
    """
    match ability_info["NAME"]:
        "TUNNELING" : return Tunneling.new(ability_info)
        "FLY"       : return Fly.new(ability_info)
        "ARCHER"    : return Archer.new(ability_info)
        "NEUTRAL"   : return Neutral.new(ability_info)
        _           : return BaseAbility.new(ability_info)
