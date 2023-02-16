extends "res://engine/abilities2/dimension_ability.gd"

# variables
var type

func _init(ability_dict).(ability_dict):
    type = ability_dict["TYPE"]

# public functions
func on_dimension():
    var attack_buff = 0
    var defense_buff = 0
    var total_graveyard = monster.player.graveyard + monster.player.opponent.graveyard
    for dead_monster in total_graveyard:
        if dead_monster.NAME == type:
            attack_buff += dead_monster.card.attack
            defense_buff += dead_monster.card.defense
    monster.attack += attack_buff
    monster.defense += defense_buff
