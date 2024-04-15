extends RefCounted
## Summon card that is part of a dice.
##
## A summon card holds the information of a summon that can be later summoned
## into the dungeon.

#region preloads
const AbilityCreator = preload("res://engine/abilities/ability_creator.gd")
#endregion

#region variables
var name           ## Name of the summon
var type           ## Type of the summon
var level          ## Level of the summon
var abilities = [] ## Abilities of the summon
#endregion

#region builtin functions
func _init(cardinfo):
    name = cardinfo["NAME"]
    type = cardinfo["TYPE"]
    level = cardinfo["LEVEL"]
    for ability_info in cardinfo["ABILITY"]:
        var ability = AbilityCreator.create_ability(ability_info)
        abilities.append(ability)
#endregion
