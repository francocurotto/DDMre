extends "item_manual_ability.gd"
## MONSTERREBORN ability.
##
## Make a dimensioned dice, where the summoned monster has already been
## destroyed, available again for dimension.

#region public functions
## Activate ability. Use [param activate_dict] parameter to get the dice to
## mark as not dimensioned, and use [param monster] to erase the selected 
## monster from the graveyard array.
func activate(monster, activate_dict):
    var dice = monster.player.dicepool[activate_dict["diceidx"]]
    dice.dimensioned = false
    var reborn_monster = get_reborn_monster(monster.player, dice)
    monster.player.graveyard.erase(reborn_monster)

## Get an array of dice available to revive. Use [param monster] to get the 
## array of monsters from player in graveyard. Used for the ability interface
## that the player use to activate the ability.
func get_select_dice(monster):
    var graveyard = monster.player.graveyard
    var dicepool = monster.player.dicepool
    var cards = graveyard.map(func(_monster): return _monster.card)
    var dice_array = dicepool.filter(func(dice): return dice.card in cards)
    return dice_array
#endregion

#region private functions
## Get the monster in [param player] graveyard that was summoned with
## [param dice].
func get_reborn_monster(player, dice):
    for monster in player.graveyard:
        if monster.card == dice.card:
            return monster
#endregion
