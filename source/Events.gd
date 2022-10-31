extends Node
signal duel_update(cmdname) # when the duel is updated in any way
signal dice_rolled(sides) # when a triple of dice is rolled in ROLL state
signal card_summoned(diceidx) # when a card is summoned into the dungeon
signal state_update(statename) # when the state is updated
signal next_turn(turn) # when the turn changes
signal player_lost(player) # when a player looses
