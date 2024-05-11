extends "continuous_ability.gd"
## TURNSLOWTYPE ability.
##
## All monsters of specific type have their movement disabled every other 
## opponent turn. Starts by disabling monsters movement at the end of the 
## opponent turn that follows the turn of this monster summon. 

#region variables
var type ## Type of monster to disabled movement
var effect_flag = false ## Internal variable to control movement disabling
#endregion

#region builtin functions
func _init(ability_dict):
    super(ability_dict)
    type = ability_dict["TYPE"]
#endregion

#region public functions
## Deactivate ability. If in turn of movement disabling, re-enable movement
## of all monsters of defined type.
func deactivate():
    super()
    if effect_flag:
        enable_monsters_movement()
#endregion

#region signals callbacks
## For each end of turn of opponent of [param player], disable or re-enable 
## movement of monsters of defined type. The turn of disabling and re-enabling
## is alternated using the [code]effect_flag[/code] boolean.
func on_next_turn(player, _turn):
    # update effect on opponent turn
    if summon.player != player:
        effect_flag = not effect_flag
        if effect_flag:
            disable_monsters_movement()
        else:
            enable_monsters_movement()

## When new summon occurs, if in turn of movement disabling, and if monster is
## of defined type, disable monster movement.
func on_new_summon(_summon):
    if effect_flag:
        if _summon.TYPE == type:
            _summon.max_move_behavior.add_limit(0)
#endregion

#region private functions
## Add zero movement limit to all monsters of defined type.
func disable_monsters_movement():
    for monster in dungeon.monsters:
        if monster.TYPE == type:
            monster.max_move_behavior.add_limit(0)
        
## Remove zero movement limit to all monsters of defined type.
func enable_monsters_movement():
    for monster in dungeon.monsters:
        if monster.TYPE == type:
            monster.max_move_behavior.remove_limit(0)
#endregion
