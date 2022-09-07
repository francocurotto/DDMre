extends "monster.gd"

# constants
const NAME = "UNDEAD"

func _init(_card, _player).(_card, _player):
    pass

# public functions
func get_power(attacked):
    return attacked.get_attacker_power_undead(self)

func get_attacker_power_spellcaster(attacker):
    return attacker.attack + 10

func get_attacker_power_beast(attacker):
    return attacker.attack - 10
