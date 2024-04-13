extends "summon.gd"
## A monster is a dungobj that can move and attack.
## 
## The most fundamental dungobj, monsters move through the dungeon and attack
## other monsters and the opponent monster lord, to try to win the game. When
## a monster health points reaches to zero, the monster is destroyed. Some
## monsters can also activate abilities, in manual or an automatic way. This
## class must be extended to add monster type attribute to monsters.

#region signals
signal attack_ends
#endregion

#region preloads
const PassBehaviorBase = preload("res://engine/dungobj/behaviors/pass_behavior_base.gd")
const TargetBehaviorBase = preload("res://engine/dungobj/behaviors/target_behavior_base.gd")
const PowerBehaviorBase = preload("res://engine/dungobj/behaviors/power_behavior_base.gd")
const DamageBehaviorBase = preload("res://engine/dungobj/behaviors/damage_behavior_base.gd")
const MaxMoveBehaviorBase = preload("res://engine/dungobj/behaviors/max_move_behavior_base.gd")
const AttackCooldownBehaviorBase = preload("res://engine/dungobj/behaviors/attack_cooldown_behavior_base.gd")
#endregion

#region variables
var attack ## Current attack power of monster
var defense ## Current defense power of monster
var health ## Current health points of monster
var speed = 1 ## Number of tiles a monster can move per movement crest
var attack_distance = 1 ## Max distance a monster can attack in # of tiles
var attack_cost = 1 ## Attack crest that must be pay per attack
var ability_cooldown = false ## Track if monster has casted an ability in a turn
var max_move : get = get_max_move ## Max tiles monster can move per turn
var previous_tile = null ## Tile where monster was before last movement
var pass_behavior ## Behavior of monster when other monster pass thorugh it
var target_behavior ## Behavior of monster when is targeted for an attack
var power_behavior ## Behavior of monster when computing its attack power
var damage_behavior ## Behavior of monster when receiving damage from an attack
var max_move_behavior ## Behavior to track its max number of tiles to move
var attack_cooldown_behavior ## Behavior of monster to track its attack cooldown
#endregion

#region builtin functions
func _init(_card, _player):
    super(_card, _player)
    # get initial stats from monster card
    attack = card.attack
    defense = card.defense
    health = card.health
    # initialize behaviors
    pass_behavior = PassBehaviorBase.new()
    target_behavior = TargetBehaviorBase.new()
    power_behavior = PowerBehaviorBase.new(self)
    damage_behavior = DamageBehaviorBase.new(self)
    max_move_behavior = MaxMoveBehaviorBase.new()
    attack_cooldown_behavior = AttackCooldownBehaviorBase.new()
#endregion

#region public functions
## Attack an opponent [param monster]. If [param guard] is true, the attacked 
## moster guards the attack.
func attack_monster(monster, guard):
    attack_cooldown_behavior.activate()
    var damage = get_damage(monster, guard)
    if damage > 0: # attacker deals damage
        monster.receive_damage(damage)
    elif damage < 0: # attacker receives retailation damage
        receive_damage(-damage)
    emit_signal("attack_ends")
    monster.emit_signal("attack_ends")

## Attack the opponent [param monster_lord].
func attack_monster_lord(monster_lord):
    attack_cooldown_behavior.activate()
    monster_lord.receive_damage()

## Receive an amount of [param damage] from an attack or ability.
func receive_damage(damage):
    damage_behavior.receive_damage(damage)

## Remove monster from dungeon due to being destroyed by attack or ability.
func destroy():
    super.destroy()
    player.remove_moster(self)

## Buff monster attribute [param attr] by [param amount].
func buff_attr(attr, amount):
    attr = attr.to_lower()
    set(attr, get(attr) + amount)

## Debuff monster attribute [param attr] by [param amount].
func debuff_attr(attr, amount):
    attr = attr.to_lower()
    set(attr, max(get(attr) - amount, 0))
    
## Restore monster health by [param amount], limited by the original amount of
## monster card.
func restore_health(amount):
    health = min(health + amount, card.health)

## Change monster player ownership to the opponent player.
func switch_player():
    player.monsters.erase(self)
    player = player.opponent
    player.monsters.append(self)

## Get max movement allowed by abilities.
func get_max_move():
    return max_move_behavior.get_max_move()

## Return an array of player monsters without this monster.
func get_player_other_monsters():
    var other_monsters = player.monsters
    other_monsters.erase(self)
    return other_monsters

## Get damage from an attack of a [param monster]. If [param guard] is true,
## compute damage with this monster guarding the attack. Else compute damage
## with this monster waiting the attack.
func get_damage(monster, guard):
    # "int(guard)*" accounts for attacking a guarding or not guarding monster
    return get_power(monster) - int(guard)*monster.defense

## Get the attack power for monster attacking [param attacked].
func get_power(attacked):
    return power_behavior.get_power(attacked)
#endregion

#region is functions
func is_monster():
    return true

## Return true if [param monster], can pass through this monster during 
## movement.
func is_passable_by(monster):
    return monster == self or monster.pass_behavior.can_pass(self)

## Return true if [param monster], can target this monster for an attack.
func can_target(monster):
    return monster.player != player and target_behavior.can_target(monster)

## By default, monsters have no advantage when attacking monster
## [param _attacked].
func has_adv(_attacked):
    return false

## Return true if monster has disadvantage when attacking monster 
## [param attacked]. Is computed by checking if monster [param attacked] has
## advantage over this monster.
func has_disadv(attacked):
    return attacked.has_adv(self)

## By default, monsters have no disadvantage over dragon type.
func has_disadv_over_dragon():
    return false

## By default, monsters have no disadvantage over spellcarter type.
func has_disadv_over_spellcaster():
    return false

## By default, monsters have no disadvantage over undead type.
func has_disadv_over_undead():
    return false

## By default, monsters have no disadvantage over beast type.
func has_disadv_over_beast():
    return false

## By default, monsters have no disadvantage over warrior type.
func has_disadv_over_warrior():
    return false
#endregion
