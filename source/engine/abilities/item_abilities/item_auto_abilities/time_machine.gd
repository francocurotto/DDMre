extends "item_auto_ability.gd"
## TIMEMACHINE ability.
##
## Return monster to its previous position, before last movement.

#region public functions
## Activate ability. Return [param monster] to its previous position.
func activate(monster):
    monster.previous_tile.move_content_from(monster.tile)
#endregion
