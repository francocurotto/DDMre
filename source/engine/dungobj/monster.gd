extends "summon.gd"

# variables
var attack
var defense
var health
var cooldown = false

# signals
signal monster_death(monster)

func _init(_card, _player).(_card, _player):
    attack = card.attack
    defense = card.defense
    health = card.health

# is functions
func is_monster():
    return true

# private functions
func attack_monster(monster, guard):
    """
    Attack an opponent monster.
    """
    cooldown = true
    var attack_power = get_power(monster)
    if not guard:
        monster.receive_attack_damage(attack_power)
        
func attack_monster_lord(ml):
    """
    Attack the opponent monster lord.
    """
    cooldown = true
    ml.receive_damage()

func receive_attack_damage(damage):
    health -= damage
    if health <= 0:
        emit_signal("monster_death", self)

func get_power(attacked): # written just to avoid editor error
    return attacked.attack

func get_attacker_power_dragon(attacker):
    return attacker.attack

func get_attacker_power_spellcaster(attacker):
    return attacker.attack

func get_attacker_power_undead(attacker):
    return attacker.attack

func get_attacker_power_beast(attacker):
    return attacker.attack

func get_attacker_power_warrior(attacker):
    return attacker.attack
