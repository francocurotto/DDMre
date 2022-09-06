extends "monster.gd"

# constants
const NAME = "BEAST"

func _init(_card, _player).(_card, _player):
    pass

# public functions
func get_power(monster):
    return monster.get_attacker_power_beast(self)

func get_attacker_power_undead(monster):
    return monster.attack + 10

func get_attacker_power_warrior(monster):
    return monster.attack - 10
