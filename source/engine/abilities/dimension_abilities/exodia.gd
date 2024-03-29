extends "res://engine/abilities/dim_auto_ability.gd"

func _init(ability_dict).(ability_dict):
    pass

# public functions
func activate():
    var r_leg = false
    var l_leg = false
    var r_arm = false
    var l_arm = false
    for monster in summon.player.monsters:
        match monster.card.name:
            "R Leg of Forbidden" : r_leg = true
            "L Leg of Forbidden" : l_leg = true
            "R Arm of Forbidden" : r_arm = true
            "L Arm of Forbidden" : l_arm = true
    if r_leg and l_leg and r_arm and l_arm:
        Events.emit_signal("player_lost", summon.player.opponent)
