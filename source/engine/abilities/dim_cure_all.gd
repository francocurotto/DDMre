extends "base_ability.gd"

# variables
var amount

func _init(ability_dict).(ability_dict):
    amount = ability_dict["AMOUNT"]

# public functions
func summon_activate():
    for player_monster in summon.player.monsters:
        player_monster.restore_health(amount)
