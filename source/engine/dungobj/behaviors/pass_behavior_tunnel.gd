extends RefCounted
## Tunnel monster behavior when attempting to pass through other monsters.

#region public functions
## Tunnel monsters can pass through all other monsters.
func can_pass(_monster):
    return true
#endregion
