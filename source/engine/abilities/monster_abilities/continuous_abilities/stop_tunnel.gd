extends "res://engine/abilities/continuous_ability.gd"

func _init(ability_dict):
    super(ability_dict)
    pass

# public functions
func activate():
    super.activate()
    #GODOT4: use array filter
    for monster in dungeon.monsters:
        if monster.has_ability("TUNNEL"):
            monster.get_ability("TUNNEL").negate()

func deactivate():
    super.deactivate()
    #GODOT4: use array filter
    for monster in dungeon.monsters:
        if monster.has_ability("TUNNEL"):
            monster.get_ability("TUNNEL").remove_negate()

# signals callbacks
func on_new_summon(_summon, _net):
    if _summon.has_ability("TUNNEL"):
        _summon.get_ability("TUNNEL").negate()
