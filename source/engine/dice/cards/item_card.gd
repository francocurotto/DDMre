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
    var item = Item.new(self, player)
    player.items.append(item)
    return item

# is functions
func is_item():
    return true
