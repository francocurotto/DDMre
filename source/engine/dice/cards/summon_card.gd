extends Reference

# variables
var name
var type
var level
var abilities

func _init(cardinfo):
    name = cardinfo["NAME"]
    type = cardinfo["TYPE"]
    level = cardinfo["LEVEL"]
    abilities = []
    for ability_info in cardinfo["ABILITY"]:
        abilities.append(create_ability(ability_info))

# is functions
func is_monster():
    return false

func is_item():
    return false

# private functions
const Tunnel = preload("res://engine/abilities/dimension_abilities/tunnel.gd")
const Fly = preload("res://engine/abilities/dimension_abilities/fly.gd")
const Archer = preload("res://engine/abilities/dimension_abilities/archer.gd")
const Neutral = preload("res://engine/abilities/dimension_abilities/neutral.gd")
const DimCureAll = preload("res://engine/abilities/dimension_abilities/dim_cure_all.gd")
const DimAddCrest = preload("res://engine/abilities/dimension_abilities/dim_add_crest.gd")
const Exodia = preload("res://engine/abilities/dimension_abilities/exodia.gd")
const DimBuffDeadType = preload("res://engine/abilities/dimension_abilities/dim_buff_dead_type.gd")
const StopFly = preload("res://engine/abilities/continuous_abilities/stop_fly.gd")
const StopTunnel = preload("res://engine/abilities/continuous_abilities/stop_tunnel.gd")
const TurnSlowType = preload("res://engine/abilities/continuous_abilities/turn_slow_type.gd")
const BuffType = preload("res://engine/abilities/continuous_abilities/buff_type.gd")
const ProtectType = preload("res://engine/abilities/continuous_abilities/protect_type.gd")
const Frozen = preload("res://engine/abilities/dimension_abilities/frozen.gd")
const MoveLimit = preload("res://engine/abilities/dimension_abilities/move_limit.gd")
const RaiseSpeed = preload("res://engine/abilities/dimension_abilities/raise_speed.gd")
const RaiseAttack = preload("res://engine/abilities/attack_abilities/raise_attack.gd")
const ReduceDamage = preload("res://engine/abilities/reply_abilities/reduce_damage.gd")
const ReduceDamageInf = preload("res://engine/abilities/reply_abilities/reduce_damage_inf.gd")
const ShiftDamage = preload("res://engine/abilities/reply_abilities/shift_damage.gd")
const ProtectSelf = preload("res://engine/abilities/reply_abilities/protect_self.gd")
const AddFoeDefense = preload("res://engine/abilities/reply_abilities/add_foe_defense.gd")
const BuffDamage = preload("res://engine/abilities/standing_abilities/buff_damage.gd")
const BuffSelf = preload("res://engine/abilities/standing_abilities/buff_self.gd")
const TradeHealth = preload("res://engine/abilities/standing_abilities/trade_health.gd")
const StealMonster = preload("res://engine/abilities/standing_abilities/steal_monster.gd")
const MindControl = preload("res://engine/abilities/standing_abilities/mind_control.gd")
const RangeKillAll = preload("res://engine/abilities/standing_abilities/range_kill_all.gd")
const DistanceAttack = preload("res://engine/abilities/standing_abilities/distance_attack.gd")
const ItemCure = preload("res://engine/abilities/manual_item_abilities/item_cure.gd")
const ItemDamage = preload("res://engine/abilities/manual_item_abilities/item_damage.gd")
const TimeMachine = preload("res://engine/abilities/manual_item_abilities/time_machine.gd")
const ItemBuff = preload("res://engine/abilities/manual_item_abilities/item_buff.gd")
const ItemCrestKill = preload("res://engine/abilities/manual_item_abilities/item_crest_kill.gd")
const BlackHole = preload("res://engine/abilities/manual_item_abilities/black_hole.gd")
const Gluminizer = preload("res://engine/abilities/dimension_item_abilities/gluminizer.gd")
const WarpVortex = preload("res://engine/abilities/dimension_item_abilities/warp_vortex.gd")
const Ability = preload("res://engine/abilities/ability.gd")
func create_ability(ability_info):
    """
    Creates ability object from ability info dict.
    """
    match ability_info["NAME"]:
        "TUNNEL"          : return Tunnel.new(ability_info)
        "FLY"             : return Fly.new(ability_info)
        "ARCHER"          : return Archer.new(ability_info)
        "NEUTRAL"         : return Neutral.new(ability_info)
        "DIMCUREALL"      : return DimCureAll.new(ability_info)
        "DIMADDCREST"     : return DimAddCrest.new(ability_info)
        "EXODIA"          : return Exodia.new(ability_info)
        "DIMBUFFDEADTYPE" : return DimBuffDeadType.new(ability_info)
        "STOPFLY"         : return StopFly.new(ability_info)
        "STOPTUNNEL"      : return StopTunnel.new(ability_info)
        "TURNSLOWTYPE"    : return TurnSlowType.new(ability_info)
        "BUFFTYPE"        : return BuffType.new(ability_info)
        "PROTECTTYPE"     : return ProtectType.new(ability_info)
        "FROZEN"          : return Frozen.new(ability_info)
        "MOVELIMIT"       : return MoveLimit.new(ability_info)
        "RAISESPEED"      : return RaiseSpeed.new(ability_info)
        "RAISEATTACK"     : return RaiseAttack.new(ability_info)
        "REDUCEDAMAGE"    : return ReduceDamage.new(ability_info)
        "REDUCEDAMAGEINF" : return ReduceDamageInf.new(ability_info)
        "SHIFTDAMAGE"     : return ShiftDamage.new(ability_info)
        "PROTECTSELF"     : return ProtectSelf.new(ability_info)
        "ADDFOEDEFENSE"   : return AddFoeDefense.new(ability_info)
        "BUFFDAMAGE"      : return BuffDamage.new(ability_info)
        "BUFFSELF"        : return BuffSelf.new(ability_info)
        "TRADEHEALTH"     : return TradeHealth.new(ability_info)
        "STEALMONSTER"    : return StealMonster.new(ability_info)
        "MINDCONTROL"    : return MindControl.new(ability_info)
        "RANGEKILLALL"    : return RangeKillAll.new(ability_info)
        "DISTANCEATTACK"  : return DistanceAttack.new(ability_info)
        "ITEMCURE"        : return ItemCure.new(ability_info)
        "ITEMDAMAGE"      : return ItemDamage.new(ability_info)
        "TIMEMACHINE"     : return TimeMachine.new(ability_info)
        "ITEMBUFF"        : return ItemBuff.new(ability_info)
        "ITEMCRESTKILL"   : return ItemCrestKill.new(ability_info)
        "BLACKHOLE"       : return BlackHole.new(ability_info)
        "GLUMINIZER"      : return Gluminizer.new(ability_info)
        "WARPVORTEX"      : return WarpVortex.new(ability_info)
        _                 : return Ability.new(ability_info)
