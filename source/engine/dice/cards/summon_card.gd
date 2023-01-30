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
const ItemCure = preload("res://engine/abilities/item_cure.gd")
const ItemDamage = preload("res://engine/abilities/item_damage.gd")
const ItemBuff = preload("res://engine/abilities/item_buff.gd")
const ItemCrestKill = preload("res://engine/abilities/item_crest_kill.gd")
const BlackHole = preload("res://engine/abilities/black_hole.gd")
const BaseAbility = preload("res://engine/abilities/base_ability.gd")
func create_ability(ability_info):
    """
    Creates ability object from ability info dict.
    """
    match ability_info["NAME"]:
        "TUNNEL"        : return Tunnel.new(ability_info)
        "FLY"           : return Fly.new(ability_info)
        "ARCHER"        : return Archer.new(ability_info)
        "NEUTRAL"       : return Neutral.new(ability_info)
        "ITEMCURE"      : return ItemCure.new(ability_info)
        "ITEMDAMAGE"    : return ItemDamage.new(ability_info)
        "ITEMBUFF"      : return ItemBuff.new(ability_info)
        "ITEMCRESTKILL" : return ItemCrestKill.new(ability_info)
        "BLACKHOLE"     : return BlackHole.new(ability_info)
        _               : return BaseAbility.new(ability_info)
