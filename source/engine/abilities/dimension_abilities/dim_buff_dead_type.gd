extends "dimension_ability.gd"

# variables
var TYPE

func _init(ability_dict).(ability_dict):
    TYPE = ability_dict["TYPE"]

# public functions
func on_dimension():
    var attack_buff = 0
    var defense_buff = 0
    var total_graveyard = monster.player.graveyard + monster.player.opponent.graveyard
    for dead_monster in total_graveyard:
        if dead_monster.TYPE == TYPE:
            attack_buff += dead_monster.card.attack
            defense_buff += dead_monster.card.defense
    monster.attack += attack_buff
    monster.defense += defense_buff
