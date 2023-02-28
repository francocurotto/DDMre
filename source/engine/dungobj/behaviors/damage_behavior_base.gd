extends Reference

# variables
var damage_limits = [INF]
var ability_reduce = 0

# public functions
func get_inflicted_damage(damage):
    """
    Get the inflicted damage on a monster considering the damage of an attack,
    but also the damage limit that abilities may have imposed.
    """
    var reduced_damage = max(0, damage-ability_reduce)
    var limited_damage = min(reduced_damage, damage_limits.min())
    return limited_damage

func add_limit(limit):
    """
    Add a limit to the damage limits array.
    """
    damage_limits.append(limit)

func remove_limit(limit):
    """
    Remove a limit from the damage limits array.
    """
    damage_limits.erase(limit)
    

