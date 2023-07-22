extends "res://engine/abilities/continuous_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func activate():
    .activate()
    #GODOT4: use array filter
    for monster in dungeon.monsters:
        if monster.has_ability("FLY"):
            monster.get_ability("FLY").negate()

func deactivate():
    .deactivate()
    #GODOT4: use array filter
    for monster in dungeon.monsters:
        if monster.has_ability("FLY"):
            monster.get_ability("FLY").negate()

# signals callbacks
func on_new_summon(_summon):
    if _summon.has_ability("FLY"):
        _summon.get_ability("FLY").negate()
