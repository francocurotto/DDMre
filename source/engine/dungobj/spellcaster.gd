extends "monster.gd"

# constants
const NAME = "SPELLCASTER"

func _init(_card, _player).(_card, _player):
    pass

# public functions
func get_power(monster):
    return monster.get_attacker_power_spellcaster(self)

func get_attacker_power_dragon(monster):
    return monster.attack + 10

func get_attacker_power_undead(monster):
    return monster.attack - 10
