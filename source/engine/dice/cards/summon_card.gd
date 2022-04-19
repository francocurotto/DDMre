extends Reference

var name
var type
var level
var ability

func _init(cardinfo):
	name = cardinfo["NAME"]
	type = cardinfo["TYPE"]
	level = cardinfo["LEVEL"]
	ability = cardinfo["ABILITY"] #TODO: change to proper abi

func is_monster():
	return false
func is_item():
	return false
