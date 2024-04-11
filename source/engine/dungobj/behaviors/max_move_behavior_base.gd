extends RefCounted
## Monster behavior to handle the max number of tiles it can move per turn.
##
## Max move behavior base tracks the number of tiles a monster have moved each
## turn and limits its movement to the lowest value in an array of turn move
## limits. Normally, a monster has no limits of movement so the default value
## on [code]turn_move_limits[/code] is infinity. Some monsters have abilities
## that limits its movement, so limit values are added to 
## [code]turn_move_limits[/code] array. Movement can be suppresed entirely by
## adding 0 to [code]turn_move_limits[/code].

#region variables
var turn_move_limits = [INF] ## Array of all movement limits for monster
var turn_move_count = 0 ## Variable to track the number of moves in turn
##endregion

#region public functions
## Get the current maximum movement allowed by a monster, taking into account
## turn move limits added by abilities.
func get_max_move():
    return turn_move_limits.min() - turn_move_count

## Add [param move] value to current turn move count.
func update_turn_move_count(move):
    turn_move_count += move

## Reset turn move count to 0. Usually done at the end of a turn.
func reset_turn_move_count():
    turn_move_count = 0 

## Add value [param limit] to the turn move limits array.
func add_limit(limit):
    turn_move_limits.append(limit)

## Remove value [param limit] from the turn move limits array.
func remove_limit(limit):
    turn_move_limits.erase(limit)
#endregion
