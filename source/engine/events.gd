extends Node
## Autoload for DDMre engine events.
##
## Autoload used to report DDMre engine to the outside world. It is also used 
## internally by the DDMre engine for logic better suited for signals (e.g. 
## ability actions on summons).

#region signals
## Emit when dice are rolled and send the result of the roll in the
## [param sides] parameter. Used to display the result of a roll in the 
## interface.
signal dice_rolled(sides)

## Emit when a new [param summon] is placed in the dungeon. It covers dice 
## dimensions and summons placements during the dungeon initialization.
signal new_summon(summon)

## Emit when a dice is dimensioned on the dungeon, and [param net] is placed.
signal dice_dimensioned(net)

## Emit when a new turn starts and send the turn [param player] and the 
## [param turn] number count.
signal next_turn(player, turn)

## Emit when one of the players lose the game and send the loser 
## [param player]. Used to finish the duel after the a player loses the game.
signal player_lost(player)
#endregion
