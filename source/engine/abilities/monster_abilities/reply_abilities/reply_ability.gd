extends "res://engine/abilities/monster_abilities/monster_ability.gd"

# constants
const TYPE = "REPLY"

func _init(ability_dict):
    super(ability_dict)
    pass

# public functions
func activate(_attacker, _activate_dict):
    summon.connect("attack_ends", Callable(self, "deactivate"))

func deactivate():
    summon.disconnect("attack_ends", Callable(self, "deactivate"))
