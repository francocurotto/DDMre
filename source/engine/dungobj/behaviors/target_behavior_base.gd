extends RefCounted
## Monster behavior to define possible attacking targets for monster.
##
## Normally, monsters can attack any opponent monster that are not flying 
## monsters.

# public functions
## Return true if [param opponent_monster] has not the active ability "FLY".
func can_target(opponent_monster):
    return not opponent_monster.has_active_ability("FLY")
