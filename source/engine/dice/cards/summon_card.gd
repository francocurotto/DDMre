extends Reference

# preloads
const AbilitySlots = preload("res://engine/abilities/ability_slots.gd")

# variables
var name
var type
var level
var abilities

func _init(cardinfo):
    name = cardinfo["NAME"]
    type = cardinfo["TYPE"]
    level = cardinfo["LEVEL"]
    abilities = AbilitySlots.new(cardinfo["ABILITY"])

# is functions
func is_monster():
    return false

func is_item():
    return false
