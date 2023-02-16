extends "monster_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func enable():
    monster.connect("attack_ends", self, "on_attack_ends")

func disable():
    monster.disconnect("attack_ends", self, "on_attack_ends")
