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

# public functions
func attack_monster(monster, guard):
    """
    Attack an opponent monster.
    """
    cooldown = true
    var damage = get_damage(monster, guard)
    if damage > 0: # attacker deals damage
        monster.receive_damage(damage)
    elif damage < 0: # attacker receives retailation damage
        receive_damage(-damage)
        
func attack_monster_lord(ml):
    """
    Attack the opponent monster lord.
    """
    cooldown = true
    ml.receive_damage()

# private functions
func get_damage(monster, guard):
    """
    Get damage for an attack.
    """
    # "guard*" accounts for attacking a guarding or not guarding monster
    return get_power(monster) - int(guard)*monster.defense

func receive_damage(damage):
    """
    Receive damage from an attack or ability.
    """
    health -= damage
    if health <= 0:
        emit_signal("monster_death", self)

func get_power(_attacked): # written just to avoid editor error
    return attack

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

# is functions
func is_monster():
    return true
