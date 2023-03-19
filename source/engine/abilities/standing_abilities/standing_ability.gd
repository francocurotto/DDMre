extends "res://engine/abilities/monster_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func enable():
    .enable()
    Events.connect("next_turn", self, "on_next_turn")

func disable():
    Events.disconnect("next_turn", self, "on_next_turn")

func on_next_turn(_player, _turn):
    pass

# is functions
func is_standing():
    return true
