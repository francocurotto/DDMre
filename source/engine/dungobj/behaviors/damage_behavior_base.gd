extends Reference

# variables
var damage_limits = [INF]

# public functions
func get_inflicted_damage(damage):
    """
    Get the inflicted damage on a monster considering the damage of an attack,
    but also the damage limit that abilities may have imposed.
    """
    return min(damage, damage_limits.min())

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
    

