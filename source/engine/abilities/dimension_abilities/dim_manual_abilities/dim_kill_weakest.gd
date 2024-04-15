extends "dim_manual_ability.gd"

func _init(ability_dict):
    super(ability_dict)
    pass

# public functions
func activate(activate_dict):
    var pos = activate_dict["pos"]
    var monster = dungeon.get_tile(pos).content
    monster.destroy()

func get_select_tiles():
    return get_weakest_monsters_tiles()

