extends "dim_auto_ability.gd"
## WARPVORTEX ability. 
##
## Summon a warp vortex in item position.

#region public functions
## Activate ability. Summon warp vortex and destroy item.
func activate():
    summon.tile.vortex = true
    summon.destroy()
#endregion
