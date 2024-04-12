extends RefCounted
## Default monster behavior when attempting to pass through other monsters.

#region public functions
## By default, monsters can only pass through other flying monsters.
func can_pass(monster):
    return monster.has_active_ability("FLY")
#endregion
