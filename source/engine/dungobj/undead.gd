extends "monster.gd"

# constants
const NAME = "UNDEAD"

func _init(_card, _player).(_card, _player):
    pass

# public functions
func get_power(monster):
    return monster.get_attacker_power_undead(self)

func get_attacker_power_spellcaster(monster):
    return monster.attack + 10

func get_attacker_power_beast(monster):
    return monster.attack - 10
