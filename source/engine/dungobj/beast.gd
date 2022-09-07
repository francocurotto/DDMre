extends "monster.gd"

# constants
const NAME = "BEAST"

func _init(_card, _player).(_card, _player):
    pass

# public functions
func get_power(attacked):
    return attacked.get_attacker_power_beast(self)

func get_attacker_power_undead(attacker):
    return attacker.attack + 10

func get_attacker_power_warrior(attacker):
    return attacker.attack - 10
