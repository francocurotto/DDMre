extends "base_ability.gd"

# variables
var type
var effect_flag = false

func _init(ability_dict).(ability_dict):
    type = ability_dict["TYPE"]

# public functions
func on_next_turn(player, _turn):
    # update effect on opponent turn
    if summon.player != player:
        effect_flag = ~effect_flag
    # apply effect if effect flag is on, remove effect if off
    for monster in dungeon.monsters:
        if monster.NAME == type:
            if effect_flag:
                summon.max_move_behavior.add_limit(0)
            else:
                summon.max_move_behavior.remove_limit(0)

func on_new_summon(new_summon):
    # add effect if effect flag is on
    if new_summon.NAME == type:
        if effect_flag:
            summon.max_move_behavior.add_limit(0)

func deactivate():
    # remove effect if effect flag is on
    for monster in dungeon.monsters:
        if monster.NAME == type:
            if effect_flag:
                summon.max_move_behavior.remove_limit(0)
