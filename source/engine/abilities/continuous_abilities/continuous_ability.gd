extends "res://engine/abilities/dimension_abilities/dimension_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func enable():
    .enable()
    Events.connect("new_summon", self, "on_new_summon")
    Events.connect("next_turn", self, "on_next_turn")

func disable():
    Events.disconnect("new_summon", self, "on_new_summon")
    Events.disconnect("next_turn", self, "on_next_turn")

func on_new_summon(_summon):
    pass

func on_next_turn(_player, _turn):
    pass