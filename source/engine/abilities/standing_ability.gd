extends "res://engine/abilities/linger_ability.gd"

# constants
const TYPE = "STANDING"

func _init(ability_dict):
    super(ability_dict)
    pass

# is functions
func is_standing():
    return true
