extends "ability.gd"

# variables
var item

func _init(ability_dict).(ability_dict):
    pass

# public functions
func initialize(_item, _dungeon):
    .initialize(_item, _dungeon)
    item = _item
    enable()
