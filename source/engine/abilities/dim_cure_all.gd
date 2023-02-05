extends "base_ability.gd"

# variables
var amount

func _init(ability_dict).(ability_dict):
    amount = ability_dict["AMOUNT"]

# public functions
func on_summon(monster, _dungeon):
    for player_monster in monster.player.monsters:
        player_monster.restore_health(amount)
