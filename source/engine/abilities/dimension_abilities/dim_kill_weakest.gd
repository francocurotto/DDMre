extends "res://engine/abilities/dim_manual_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func activate(activate_dict):
    var monster = dungeon.get_tile(activate_dict["pos"]).content
    monster.destroy()

func get_select_tiles():
    return get_weakest_monsters_tiles()

