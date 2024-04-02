extends "summon_card.gd"
## Card of item type.
##
## Summon card that represents an item.

#region constants
const TYPE = "ITEM"
#endregion

#region preloads
const Item = preload("res://engine/dungobj/item.gd")
#endregion

#region builtin function
func _init(cardinfo):
    super(cardinfo)
#endregion

#region public functions
## Summon an item for player [param player] from the item card.
func summon(player):
    var item = Item.new(self, player)
    return item

## Activate item ability triggered by monster [param monster] moving into the
## item position.
func activate(monster):
    for ability in abilities:
        ability.activate(monster)
#endregion
