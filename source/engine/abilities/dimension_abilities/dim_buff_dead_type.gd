extends "res://engine/abilities/dim_auto_ability.gd"

# variables
var type

func _init(ability_dict).(ability_dict):
    type = ability_dict["TYPE"]

# public functions
func activate():
    var attack_buff = 0
    var defense_buff = 0
    var total_graveyard = summon.player.graveyard + summon.player.opponent.graveyard
    for dead_monster in total_graveyard:
        if dead_monster.TYPE == type:
            attack_buff += dead_monster.card.attack
            defense_buff += dead_monster.card.defense
    summon.attack += attack_buff
    summon.defense += defense_buff
