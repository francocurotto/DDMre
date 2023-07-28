extends Node

## Emit when the duel is updated in any way. Used to update the interface
## elements.
signal duel_update

## Emit when dice are rolled and sends the result of the roll in the
## [param sides] parameter. Used to display
signal dice_rolled(sides)

## Emit when a card is summoned into the dungeon
signal new_summon(summon) # when a card is summoned into the dungeon
signal state_update(state_name) # when the state is updated
signal next_turn(player, turn) # when the turn changes
signal player_lost(player) # when a player looses
