extends "summon_card.gd"

# constants
const TYPE = "ITEM"

# preloads
const Item = preload("res://engine/dungobj/item.gd")

func _init(cardinfo).(cardinfo):
    pass

# public functions
func summon(player):
    """
    Return a item object from card.
    """
    var item = Item.new(self, player)
    return item

func activate(monster):
    for ability in abilities:
        ability.activate(monster)
