extends "res://engine/abilities/continuous_ability.gd"

# variables
var type
var effect_flag = false

func _init(ability_dict):
    super(ability_dict)
    type = ability_dict["TYPE"]

# public functions
func deactivate():
    super.deactivate()
    # remove effect if effect flag is on
    for monster in dungeon.monsters:
        if monster.TYPE == type:
            if effect_flag:
                monster.max_move_behavior.remove_limit(0)

# signals callbacks
func on_next_turn(player, _turn):
    # update effect on opponent turn
    if summon.player != player:
        effect_flag = not effect_flag
        # apply effect if effect flag is on, remove effect if off
        for monster in dungeon.monsters:
            if monster.TYPE == type:
                if effect_flag:
                    monster.max_move_behavior.add_limit(0)
                else:
                    monster.max_move_behavior.remove_limit(0)

func on_new_summon(_summon):
    # add effect if effect flag is on
    if _summon.TYPE == type:
        if effect_flag:
            _summon.max_move_behavior.add_limit(0)
