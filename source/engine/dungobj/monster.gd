extends "summon.gd"

# preloads
const PassBehaviorBase = preload("res://engine/dungobj/behaviors/pass_behavior_base.gd")
const TargetBehaviorBase = preload("res://engine/dungobj/behaviors/target_behavior_base.gd")
const PowerBehaviorBase = preload("res://engine/dungobj/behaviors/power_behavior_base.gd")
const DamageBehaviorBase = preload("res://engine/dungobj/behaviors/damage_behavior_base.gd")
const MaxMoveBehaviorBase = preload("res://engine/dungobj/behaviors/max_move_behavior_base.gd")

# variables
var attack
var defense
var health
var cooldown = false
var speed = 1
var max_move setget , get_max_move
var previous_tile = null

# behaviors (automatic abilities)
var pass_behavior
var target_behavior
var power_behavior
var damage_behavior
var max_move_behavior

func _init(_card, _player).(_card, _player):
    attack = card.attack
    defense = card.defense
    health = card.health
    # initialize behaviors
    pass_behavior = PassBehaviorBase.new()
    target_behavior = TargetBehaviorBase.new(player)
    power_behavior = PowerBehaviorBase.new()
    damage_behavior = DamageBehaviorBase.new()
    max_move_behavior = MaxMoveBehaviorBase.new()

# setget functions
func get_max_move():
    """
    Get max movement allowed by abilities.
    """
    return max_move_behavior.get_max_move()

# public functions
func get_move_cost(path):
    """
    Get the movement cost of monster for a given path.
    """
    return ceil((len(path)-1) / speed)

func get_max_tiles(move_crests):
    """
    Get the maximum number of tiles a monster can move given a number of 
    move crests. It takes into account:
    - number of move crests
    - monster speed possibly modified by abilities
    """
    return int(move_crests * speed)
    
func can_target_monster(dungobj):
    """
    Return true if dungobj is monster type and monster can target dungobj 
    for an attack.
    """
    return target_behavior.can_target_monster(dungobj)

func can_target_ml(dungobj):
    """
    Return true if dungobj is monster lord type and monster can target dungobj 
    for an attack.
    """
    return target_behavior.can_target_ml(dungobj)

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
    power_behavior.reset_ability_buff()

func attack_monster_lord(ml):
    """
    Attack the opponent monster lord.
    """
    cooldown = true
    ml.receive_damage()

func activate_ability(ability_dict):
    """
    Activate ability given prameters in ability dict.
    """
    for ability in card.abilities:
        if ability.name == ability_dict["name"]:
            ability.activate(ability_dict)

func buff_attr(attr, amount):
    """
    Buff monster attribute attr by amount.
    """
    set(attr, get(attr) + amount)

func debuff_attr(attr, amount):
    """
    Debuff monster attribute attr by amount.
    """
    set(attr, max(get(attr) - amount, 0))
    
func restore_health(amount):
    """
    Restore monster health by amount.
    """
    health = min(health + amount, card.health)

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
    health -= damage_behavior.get_inflicted_damage(damage)
    if health <= 0:
        die()

func die():
    """
    Remove monster from play due to being kill by attack or ability.
    """
    negate_abilities()
    player.on_monster_dead(self)

func get_power(attacked):
    """
    Get the power when monster attacks attacked.
    """
    return power_behavior.get_power(attack, attacked, has_adv(attacked), has_disadv(attacked))

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
    return has_active_ability("FLY")
