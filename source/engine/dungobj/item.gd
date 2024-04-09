extends "summon.gd"
## An item is a static summon used to activate abilities.
##
## An item triggers an ability when is summoned or when a monster reaches it
## location. It cannot be moved, nor attack, and its ability cannot be
## activated manually.

#region constants
const TYPE = "ITEM"
#endregion

#region public functions
## Activate item ability triggered by [param monster] reaching its location.
func activate(monster):
    card.activate(monster)
#endregion

#region is functions
func is_item():
    return true
#endregion
