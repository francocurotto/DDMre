extends "dim_auto_ability.gd"
## DIMBUFFDEADTYPE ability.
##
## Add attack and defense of all monsters in graveyard of certain type to
## monster during dimension.

#region variables
var type ## Type of monsters in graveyard to use in ability
#endregion

##region builtin functions
func _init(ability_dict):
    super(ability_dict)
    type = ability_dict["TYPE"]
##endregion

#region public functions
## Activate ability. Add attack and defense of monsters in graveyard.
func activate():
    var attack_buff = 0
    var defense_buff = 0
    var graveyard = summon.player.graveyard + summon.player.opponent.graveyard
    for dead_monster in graveyard:
        if dead_monster.TYPE == type:
            attack_buff += dead_monster.card.attack
            defense_buff += dead_monster.card.defense
    summon.attack += attack_buff
    summon.defense += defense_buff
#endregion
