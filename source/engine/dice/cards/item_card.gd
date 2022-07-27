extends "summon_card.gd"

# preloads
const Item = preload("res://engine/dungobj/item.gd")

func _init(cardinfo).(cardinfo):
    pass

# public functions
func summon(player):
    """
    Return a item object from card.
    """
    return Item.new(self, player)

# "is" functions
func is_item():
    return true
