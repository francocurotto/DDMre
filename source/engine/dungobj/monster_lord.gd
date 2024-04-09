extends "playerobj.gd"
## Monster lord is a dungobj that represents the player in the dungeon.
##
## There is one monster lord per player in the dungeon. The monster lord
## cannot perform any actions. A monster lord holds 3 hearts. When a monster
## lord is attacked, a heart is destroyed. When all hearts are destroyed, the
## monster lord's player looses the game.

#region constants
const TYPE = "MONSTER_LORD"
const LIMIT = 3 ## Maximum number of hearts a monster lord can hold
#endregion

#region variables
var hearts = 3 ## Current number of hearts the monster lord is holding
#endregion

#region public functions
## Receive damage from a monster's attack. Results in the destruction a heart
## of the monster lord.
func receive_damage():
    set_hearts(hearts-1)
#endregion

#region is functions
func is_monster_lord():
    return true
#endregion

#region private functions
## Set number of hearts in monster lord. Clamp the value if it is off limits.
## If the number of hearts reaches 0, send a signal that the duel is lost.
func set_hearts(amount):
    # clamp amount between limits
    amount = clamp(amount, 0 , LIMIT)
    # set hearts
    hearts = amount
    # check for player lost
    if hearts <= 0:
        Events.player_lost.emit(player)
##endregion
