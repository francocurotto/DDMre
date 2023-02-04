extends "base_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func on_summon(item):
    AbilityEvents.emit_signal("gluminizer_activated")
    item.die()

func activate(_monster, _dungeon):
    pass
