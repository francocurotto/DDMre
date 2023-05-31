extends "continuous_ability.gd"

# variables
var TYPE
var effect_flag = false

func _init(ability_dict).(ability_dict):
    TYPE = ability_dict["TYPE"]

# public functions
func on_next_turn(player, _turn):
    # update effect on opponent turn
    if monster.player != player:
        effect_flag = not effect_flag
        # apply effect if effect flag is on, remove effect if off
        for dungeon_monster in dungeon.monsters:
            if dungeon_monster.NAME == TYPE:
                if effect_flag:
                    dungeon_monster.max_move_behavior.add_limit(0)
                else:
                    dungeon_monster.max_move_behavior.remove_limit(0)

func on_new_summon(summon):
    # add effect if effect flag is on
    if summon.NAME == TYPE:
        if effect_flag:
            summon.max_move_behavior.add_limit(0)

func disable():
    .disable()
    # remove effect if effect flag is on
    for dungeon_monster in dungeon.monsters:
        if dungeon_monster.NAME == TYPE:
            if effect_flag:
                dungeon_monster.max_move_behavior.remove_limit(0)
