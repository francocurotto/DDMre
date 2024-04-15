extends "res://engine/abilities/standing_ability.gd"

# variables
var cost
var crest

func _init(ability_dict):
    super(ability_dict)
    cost = ability_dict["COST"]
    crest = ability_dict["CREST"]

# public functions
func activate(activate_dict):
    pay_crests(crest, cost)
    var pos = activate_dict["pos"]
    var monster = dungeon.get_tile(pos).content
    monster.switch_player()
    var tile = summon.tile
    summon.destroy()
    tile.move_content_from(monster.tile)

func get_select_tiles():
    return get_opponent_monsters_tiles()
