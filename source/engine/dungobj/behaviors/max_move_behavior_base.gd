extends RefCounted

# variables
var turn_move_limits = [INF]
var turn_move_count = 0

# public functions
func get_max_move():
    """
    Get the maximum movement allowed by a monster, taking into account turn
    move limits added by abilities.
    """
    return turn_move_limits.min() - turn_move_count

func update_turn_move_count(move):
    """
    Update turn move count with new move steps.
    """
    turn_move_count += move

func reset_turn_move_count():
    """
    Return turn move count to 0 (e.g. after the start of a new turn).
    """
    turn_move_count = 0 

func add_limit(limit):
    """
    Add a limit to the turn move limits array.
    """
    turn_move_limits.append(limit)

func remove_limit(limit):
    """
    Remove a limit from the turn move limits array.
    """
    turn_move_limits.erase(limit)
