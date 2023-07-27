extends "res://engine/abilities/linger_ability.gd"

# constants
const TYPE = "ATTACK"

func _init(ability_dict):
    super(ability_dict)
    pass

# public functions
func activate(_activate_dict):
    summon.connect("attack_ends", Callable(self, "deactivate"))

func deactivate():
    summon.disconnect("attack_ends", Callable(self, "deactivate"))
