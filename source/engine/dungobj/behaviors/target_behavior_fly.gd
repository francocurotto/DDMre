extends RefCounted
## Monster behavior to define possible attacking targets for flying monster.
##
## Flying monsters can attack any type of opponent monsters.

# private functions
## Return true as flying monsters can attack any monster.
func can_target(_opponent_monster):
    return true
