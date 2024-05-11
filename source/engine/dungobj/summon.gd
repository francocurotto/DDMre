extends "playerobj.gd"
## Dungobj that gets summomed in a dice dimension. Either a monster or an item.
##
## A summon is created from a dice card during dimension. Some summons have
## abilities that have effects on itself, other dungobjs or the dungeon
## itself. Summon must be extended to be properly used in a duel.

#region variables
var card
#endregion

#region builtin functions
func _init(_card, _player):
    super(_player)
    card = _card
#endregion

#region public functions
## Get ability with name [param name] from summon ability list. If summon does
## not have an ability with that name, return an empty array.
func get_ability(name):
    return card.abilities.filter(func(abi): return abi.name == name)

## Remove summon from dungeon. During destruction, deactivate summon abilities
## and empty summon tile.
func destroy():
    deactivate_abilities()
    tile.empty_tile()

## Setup all abilities from summon in [param dungeon]. Usually used when
## summon is summoned.
func setup_abilities(dungeon):
    for ability in card.abilities:
        ability.setup(self, dungeon)

## Activate all abilities that triggers during summon (dimension abilities and 
## continuous abilities).
func activate_summon_abilities():
    for ability in card.abilities:
        if ability.TYPE in ["DIMAUTO", "CONTINUOUS"] and not ability.negated:
            ability.activate()

## Deactivate all abilities from summon.
func deactivate_abilities():
    for ability in card.abilities:
        if not ability.is_negated():
            ability.deactivate()

## Negate all abilities from summon.
func negate_abilities():
    for ability in card.abilities:
        ability.negate()

#region is functions
func is_summon():
    return true

## Return true if summon has ability with name [param name].
func has_ability(name):
    return card.abilities.any(func(abi): return abi.name == name)

## Return true if summon has active ability with name [param name].
func has_active_ability(name):
    return card.abilities.any(func(abi): return abi.name==name and not abi.negated)

## Return true if summon has active cast ability.
func has_active_cast_ability():
    return card.abilities.any(func(abi): return abi.TYPE=="CAST" and not abi.negated)

## Return true if summon has a dimension manual ability.
func has_dim_manual_ability():
    return card.abilities.any(func(abi): return abi.TYPE=="DIMMANUAL")

## Return true if summon has an item manual ability.
func has_item_manual_ability():
    return card.abilities.any(func(abi): return abi.TYPE=="ITEMMANUAL")
#endregion
