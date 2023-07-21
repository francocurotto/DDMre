extends "res://engine/abilities/item_manual_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func activate(monster, activate_dict):
    var dice = monster.player.dicepool[activate_dict["diceidx"]]
    dice.dimensioned = false
    var reborn_monster = get_reborn_monster(monster.player, dice)
    monster.player.graveyard.erase(reborn_monster)

func get_select_dice(monster):
    var dicelist = []
    for dice in monster.player.dicepool:
        if dice.dimensioned:
            for dead_monster in monster.player.graveyard:
                if dice.card == dead_monster.card:
                    dicelist.append(dice)
    return dicelist

# private functions
func get_reborn_monster(player, dice):
    for monster in player.graveyard:
        if monster.card == dice.card:
            return monster
