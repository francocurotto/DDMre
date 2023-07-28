extends Node
# TODO class documentation

## Emit when the duel is updated in any way. Used to update the interface
## elements.
signal duel_update

## Emit when dice are rolled and send the result of the roll in the
## [param sides] parameter. Used to display the result of a roll in the 
## interface.
signal dice_rolled(sides)

## Emit when a card is summoned into the dungeon and send the summoned 
## [param summon]. Used to react to summons, such as in abilities effects.
signal new_summon(summon)

## Emit when the engine state changes and send the new [param state_name]. Used 
## to make state dependent updates to the interface.
signal state_update(state_name)

## Emit when a new turn starts and send the turn [param player] and the 
## [param turn] number count.
signal next_turn(player, turn)

## Emit when one of the players lose the game and send the loser 
## [param player]. Used to finish the duel after the lose.
signal player_lost(player)
