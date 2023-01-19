extends Reference

# variables
var name
var type
var level
var abilities

func _init(cardinfo):
    name = cardinfo["NAME"]
    type = cardinfo["TYPE"]
    level = cardinfo["LEVEL"]
    abilities = []
    for ability_info in cardinfo["ABILITY"]:
        abilities.append(create_ability(ability_info))

# is functions
func is_monster():
    return false

func is_item():
    return false

# private functions
const Tunnel = preload("res://engine/abilities/tunnel.gd")
const Fly = preload("res://engine/abilities/fly.gd")
const Archer = preload("res://engine/abilities/archer.gd")
const Neutral = preload("res://engine/abilities/neutral.gd")
const BaseAbility = preload("res://engine/abilities/base_ability.gd")
func create_ability(ability_info):
    """
    Creates ability object from ability info dict.
    """
    match ability_info["NAME"]:
        "TUNNEL"  : return Tunnel.new(ability_info)
        "FLY"     : return Fly.new(ability_info)
        "ARCHER"  : return Archer.new(ability_info)
        "NEUTRAL" : return Neutral.new(ability_info)
        _         : return BaseAbility.new(ability_info)
