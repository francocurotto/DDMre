extends "summon.gd"

# preloads
const PassBehaviorBase = preload("res://engine/dungobj/behaviors/pass_behavior_base.gd")
const TargetBehaviorBase = preload("res://engine/dungobj/behaviors/target_behavior_base.gd")
const AdvantageBehaviorBase = preload("res://engine/dungobj/behaviors/advantage_behavior_base.gd")
const SpeedBehaviorBase = preload("res://engine/dungobj/behaviors/speed_behavior_base.gd")

# variables
var attack
var defense
var health
var cooldown = false
var speed setget , get_speed

# behaviors (automatic abilities)
var pass_behavior = PassBehaviorBase.new()
var target_behavior = TargetBehaviorBase.new(player)
var advantage_behavior = AdvantageBehaviorBase.new()
var speed_behavior = SpeedBehaviorBase.new()

# signals
signal monster_death(monster)

func _init(_card, _player).(_card, _player):
    attack = card.attack
    defense = card.defense
    health = card.health

# setget functions
func get_speed():
    """
    Get mosnter speed.
    """
    return speed_behavior.speed

func get_move_cost(path):
    """
    Get the movement cost of monster for a given path.
    """
    return int((len(path)-1) / self.speed)

# public functions
func can_target(dungobj):
    """
    Return true if monster can target dungobj for an attack.
    """
    return target_behavior.can_target(dungobj)

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

func buff_attr(attr, amount):
    """
    Buff mosnter attribute attr by amount.
    """
    set(attr, get(attr) + amount)

# private functions
func get_damage(monster, guard):
    """
    Get damage for an attack.
    """
    # "int(guard)*" accounts for attacking a guarding or not guarding monster
    return get_power(monster) - int(guard)*monster.defense

func receive_damage(damage):
    """
    Receive damage from an attack or ability.
    """
    health -= damage
    if health <= 0:
        emit_signal("monster_death", self)

func get_power(attacked):
    return advantage_behavior.get_power(attack, has_adv(attacked), has_disadv(attacked))

func has_adv(_attacked):
    """
    Return true if monster has advantage over attacked monster.
    """
    return false

func has_disadv(attacked):
    """
    Return true if monster has disadvantage over attacked monster. Computed by
    checking if attacked monster has advantage over attatcker monster.
    """
    return attacked.has_adv(self)

func has_disadv_over_dragon():
    """
    Return true if monster has disadvantage over dragon.
    """
    return false

func has_disadv_over_spellcaster():
    """
    Return true if monster has disadvantage over spellcaster.
    """
    return false

func has_disadv_over_undead():
    """
    Return true if monster has disadvantage over undead.
    """
    return false

func has_disadv_over_beast():
    """
    Return true if monster has advantage over beast.
    """
    return false

func has_disadv_over_warrior():
    """
    Return true if monster has advantage over warrior.
    """
    return false

# is functions
func is_monster():
    return true

func is_flying():
    return has_ability("FLY")
