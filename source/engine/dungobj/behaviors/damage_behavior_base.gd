extends RefCounted
## Monster behavior to handle how damage is dealt to the monster.
##
## Damage behavior base compute the reduction of health points of a monster
## given an attack with a specific damage value. Normally, damage is
## substracted directly to health points. However, monster abilities can add
## reductions and limits to the damage dealt. Damage can be suppresed entirely
## by setting the damage limit to 0. Additionally, the damage 
## [code]receiver[/code] can be change by an ability, to redirect damage to
## other monster.

#region variables
var damage_limits = [INF] ## Array of damage limits. By default, no limits
var ability_reduce = 0 ## Damage reduction added by ability
var receiver ## monster receiver of the damage
#endregion

#region builtin functions
func _init(monster):
    receiver = monster
#endregion

#region public functions
## Compute damage taking in account limits and reductions, and dealt damage to receiver. If receiver health pointa reaches 0, destry monster.
func receive_damage(damage):
    receiver.health -= get_inflicted_damage(damage)
    if receiver.health <= 0:
        receiver.destroy()

## Add a [param limit] to the damage limits array. During computation, the
## lowest limit is considered.
func add_limit(limit):
    damage_limits.append(limit)

## Remove a [param limit] from the damage limits array.
func remove_limit(limit):
    damage_limits.erase(limit)
#endregion

#region private functions
## Get the inflicted damage on a monster considering the damage of an attack,
## but also the damage limits and reductions that abilities may have imposed.
## When multiple limits are.in place, use the lowest limit.
func get_inflicted_damage(damage):
    var reduced_damage = max(0, damage-ability_reduce)
    var limited_damage = min(reduced_damage, damage_limits.min())
    return limited_damage
#endregion
