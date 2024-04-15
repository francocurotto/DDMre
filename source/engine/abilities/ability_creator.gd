extends RefCounted
## Object to create ability objects from ability dictionaries.

#region preloads
const ABILITY_DICT = {
    "TUNNEL"           : preload("res://engine/abilities/monster_abilities/continuous_abilities/tunnel.gd"),
    "FLY"              : preload("res://engine/abilities/monster_abilities/continuous_abilities/fly.gd"),
    "ARCHER"           : preload("res://engine/abilities/monster_abilities/continuous_abilities/archer.gd"),
    "NEUTRAL"          : preload("res://engine/abilities/monster_abilities/continuous_abilities/neutral.gd"),
    "DIMCURE"          : preload("res://engine/abilities/dimension_abilities/dim_manual_abilities/dim_cure.gd"),
    "DIMCUREALL"       : preload("res://engine/abilities/dimension_abilities/dim_auto_abilities/dim_cure_all.gd"),
    "DIMKILLWEAKEST"   : preload("res://engine/abilities/dimension_abilities/dim_manual_abilities/dim_kill_weakest.gd"),
    "DIMKILLTUNNEL"    : preload("res://engine/abilities/dimension_abilities/dim_manual_abilities/dim_kill_tunnel.gd"),
    "DIMKILLTUNNELALL" : preload("res://engine/abilities/dimension_abilities/dim_manual_abilities/dim_kill_tunnel_all.gd"),
    "DIMADDCREST"      : preload("res://engine/abilities/dimension_abilities/dim_auto_abilities/dim_add_crest.gd"),
    "DIMTRADECREST"    : preload("res://engine/abilities/dimension_abilities/dim_manual_abilities/dim_trade_crest.gd"),
    "EXODIA"           : preload("res://engine/abilities/dimension_abilities/dim_auto_abilities/exodia.gd"),
    "DIMBUFFDEADTYPE"  : preload("res://engine/abilities/dimension_abilities/dim_auto_abilities/dim_buff_dead_type.gd"),
    "STOPFLY"          : preload("res://engine/abilities/monster_abilities/continuous_abilities/stop_fly.gd"),
    "STOPTUNNEL"       : preload("res://engine/abilities/monster_abilities/continuous_abilities/stop_tunnel.gd"),
    "TURNSLOWTYPE"     : preload("res://engine/abilities/monster_abilities/continuous_abilities/turn_slow_type.gd"),
    "BUFFTYPE"         : preload("res://engine/abilities/monster_abilities/continuous_abilities/buff_type.gd"),
    "PROTECTTYPE"      : preload("res://engine/abilities/monster_abilities/continuous_abilities/protect_type.gd"),
    "FROZEN"           : preload("res://engine/abilities/monster_abilities/continuous_abilities/frozen.gd"),
    "MOVELIMIT"        : preload("res://engine/abilities/monster_abilities/continuous_abilities/move_limit.gd"),
    "RAISESPEED"       : preload("res://engine/abilities/monster_abilities/continuous_abilities/raise_speed.gd"),
    "MULTIATTACK"      : preload("res://engine/abilities/monster_abilities/continuous_abilities/multi_attack.gd"),
    "RAISEATTACK"      : preload("res://engine/abilities/monster_abilities/attack_abilities/raise_attack.gd"),
    "REDUCEDAMAGE"     : preload("res://engine/abilities/monster_abilities/reply_abilities/reduce_damage.gd"),
    "REDUCEDAMAGEINF"  : preload("res://engine/abilities/monster_abilities/reply_abilities/reduce_damage_inf.gd"),
    "SHIFTDAMAGE"      : preload("res://engine/abilities/monster_abilities/reply_abilities/shift_damage.gd"),
    "PROTECTSELF"      : preload("res://engine/abilities/monster_abilities/reply_abilities/protect_self.gd"),
    "ADDFOEDEFENSE"    : preload("res://engine/abilities/monster_abilities/reply_abilities/add_foe_defense.gd"),
    "KILLBLOCK"        : preload("res://engine/abilities/monster_abilities/cast_abilities/kill_block.gd"),
    "BUFFDAMAGE"       : preload("res://engine/abilities/monster_abilities/cast_abilities/buff_damage.gd"),
    "BUFFSELF"         : preload("res://engine/abilities/monster_abilities/cast_abilities/buff_self.gd"),
    "TRADEHEALTH"      : preload("res://engine/abilities/monster_abilities/cast_abilities/trade_health.gd"),
    "STEALMONSTER"     : preload("res://engine/abilities/monster_abilities/cast_abilities/steal_monster.gd"),
    "MINDCONTROL"      : preload("res://engine/abilities/monster_abilities/cast_abilities/mind_control.gd"),
    "ROLLLEVELKILL"    : preload("res://engine/abilities/monster_abilities/cast_abilities/roll_level_kill.gd"),
    "RANGELEVELKILL"   : preload("res://engine/abilities/monster_abilities/cast_abilities/range_level_kill.gd"),
    "RANGEKILLALL"     : preload("res://engine/abilities/monster_abilities/cast_abilities/range_kill_all.gd"),
    "DISTANCEATTACK"   : preload("res://engine/abilities/monster_abilities/cast_abilities/distance_attack.gd"),
    "NEGATEATKABI"     : preload("res://engine/abilities/monster_abilities/cast_abilities/negate_atk_abi.gd"),
    "ITEMCURE"         : preload("res://engine/abilities/item_abilities/item_cure.gd"),
    "ITEMDAMAGE"       : preload("res://engine/abilities/item_abilities/item_damage.gd"),
    "TIMEMACHINE"      : preload("res://engine/abilities/item_abilities/time_machine.gd"),
    "ITEMBUFF"         : preload("res://engine/abilities/item_abilities/item_buff.gd"),
    "ITEMCRESTKILL"    : preload("res://engine/abilities/item_abilities/item_crest_kill.gd"),
    "MONSTERREBORN"    : preload("res://engine/abilities/item_abilities/item_manual_abilities/monster_reborn.gd"),
    "BLACKHOLE"        : preload("res://engine/abilities/item_abilities/black_hole.gd"),
    "GLUMINIZER"       : preload("res://engine/abilities/dimension_abilities/dim_auto_abilities/gluminizer.gd"),
    "WARPVORTEX"       : preload("res://engine/abilities/dimension_abilities/dim_auto_abilities/warp_vortex.gd")}
#endregion

#region static functions
## Create an ability object from a [param ability_info] dictionary.
static func create_ability(ability_info):
    var ability_name = ability_info["NAME"]
    return ABILITY_DICT[ability_name].new(ability_info)
#endregion
