extends RefCounted

# preloads
const AbilityCreator = preload("res://engine/dice/cards/ability_creator.gd")

# variables
var name
var type
var level
var abilities = []
var ability_creator = AbilityCreator.new()

func _init(cardinfo):
    name = cardinfo["NAME"]
    type = cardinfo["TYPE"]
    level = cardinfo["LEVEL"]
    for ability_info in cardinfo["ABILITY"]:
        var ability = ability_creator.create_ability(ability_info)
        abilities.append(ability)
