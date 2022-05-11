extends "summon_card.gd"

const Item = preload("res://engine/dungobj/item.gd")

func _init(cardinfo).(cardinfo):
    pass

func is_item():
    return true

func summon(player):
    return Item.new(self, player)
