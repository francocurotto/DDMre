extends "summon.gd"

# preloads
const PassBehaviorBase = preload("res://engine/dungobj/behaviors/pass_behavior_base.gd")
const TargetBehaviorBase = preload("res://engine/dungobj/behaviors/target_behavior_base.gd")
const PowerBehaviorBase = preload("res://engine/dungobj/behaviors/power_behavior_base.gd")
const DamageBehaviorBase = preload("res://engine/dungobj/behaviors/damage_behavior_base.gd")
const MaxMoveBehaviorBase = preload("res://engine/dungobj/behaviors/max_move_behavior_base.gd")
const AttackCooldownBehaviorBase = preload("res://engine/dungobj/behaviors/attack_cooldown_behavior_base.gd")

# variables
var attack
var defense
var health
var speed = 1
var attack_distance = 1
var attack_cost = 1
var ability_cooldown = false
var max_move : get = get_max_move
var previous_tile = null
# behaviors (automatic abilities)
var pass_behavior
var target_behavior
var power_behavior
var damage_behavior
var max_move_behavior
var attack_cooldown_behavior

# signals
signal attack_ends

func _init(_card, _player):
    super(_card, _player)
    attack = card.attack
    defense = card.defense
    health = card.health
    # initialize behaviors
    pass_behavior = PassBehaviorBase.new()
    target_behavior = TargetBehaviorBase.new()
    power_behavior = PowerBehaviorBase.new()
    damage_behavior = DamageBehaviorBase.new(self)
    max_move_behavior = MaxMoveBehaviorBase.new()
    attack_cooldown_behavior = AttackCooldownBehaviorBase.new()

# setget functions
func get_max_move():
    """
    Get max movement allowed by abilities.
    """
    return max_move_behavior.get_max_move()

func get_player_other_monsters():
    """
    Return an array of player monster without this monster.
    """
    var other_monsters = player.monsters
    other_monsters.erase(self)
    return other_monsters

func get_damage(monster, guard):
    """
    Get damage for an attack.
    """
    # "int(guard)*" accounts for attacking a guarding or not guarding monster
    return get_power(monster) - int(guard)*monster.defense

func get_power(attacked):
    """
    Get the power when monster attacks attacked.
    """
    return power_behavior.get_power(attack, attacked, has_adv(attacked), has_disadv(attacked))

# public functions
func attack_monster(monster, guard):
    """
    Attack an opponent monster.
    """
    attack_cooldown_behavior.activate()
    var damage = get_damage(monster, guard)
    if damage > 0: # attacker deals damage
        monster.receive_damage(damage)
    elif damage < 0: # attacker receives retailation damage
        receive_damage(-damage)
    emit_signal("attack_ends")
    monster.emit_signal("attack_ends")

func attack_monster_lord(ml):
    """
    Attack the opponent monster lord.
    """
    attack_cooldown_behavior.activate()
    ml.receive_damage()

func receive_damage(damage):
    """
    Receive damage from an attack or ability.
    """
    damage_behavior.receive_damage(damage)

func destroy():
    """
    Remove monster from play due to being destroyed by attack or ability.
    """
    super.destroy()
    player.on_monster_destroyed(self)

func buff_attr(attr, amount):
    """
    Buff monster attribute attr by amount.
    """
    attr = attr.to_lower()
    set(attr, get(attr) + amount)

func debuff_attr(attr, amount):
    """
    Debuff monster attribute attr by amount.
    """
    attr = attr.to_lower()
    set(attr, max(get(attr) - amount, 0))
    
func restore_health(amount):
    """
    Restore monster health by amount.
    """
    health = min(health + amount, card.health)

func switch_player():
    """
    Change monster player ownership to the opponent player.
    """
    player.monsters.erase(self)
    player = player.opponent
    player.monsters.append(self)

# is functions
func is_monster():
    return true

func is_passable_by(monster):
    return monster == self or monster.pass_behavior.can_pass(self)

func can_target(monster):
    return monster.player != player and target_behavior.can_target(monster)

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
