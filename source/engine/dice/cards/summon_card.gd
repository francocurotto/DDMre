extends Reference

# variables
var name
var type
var level
var ability

func _init(cardinfo):
    name = cardinfo["NAME"]
    type = cardinfo["TYPE"]
    level = cardinfo["LEVEL"]
    ability = cardinfo["ABILITY"] #TODO: change to proper ability

# "is" functions
func is_monster():
    return false

func is_item():
    return false
