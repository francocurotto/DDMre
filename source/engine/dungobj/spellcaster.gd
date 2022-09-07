extends "monster.gd"

# constants
const NAME = "SPELLCASTER"

func _init(_card, _player).(_card, _player):
    pass

# public functions
func get_power(attacked):
    return attacked.get_attacker_power_spellcaster(self)

func get_attacker_power_dragon(attacker):
    return attacker.attack + 10

func get_attacker_power_undead(attacker):
    return attacker.attack - 10
