extends RefCounted
## Flying monster behavior when attempting to pass through other monsters.

#region public functions
## Flying monsters can pass through other monsters, except flying monsters.
func can_pass(monster):
    return not monster.has_active_ability("FLY")
#endregion
