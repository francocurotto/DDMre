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

func get_power(monster): # written just to avoid editor error
    return monster.attack

func get_attacker_power_dragon(monster):
    return monster.attack

func get_attacker_power_spellcaster(monster):
    return monster.attack

func get_attacker_power_undead(monster):
    return monster.attack

func get_attacker_power_beast(monster):
    return monster.attack

func get_attacker_power_warrior(monster):
    return monster.attack
