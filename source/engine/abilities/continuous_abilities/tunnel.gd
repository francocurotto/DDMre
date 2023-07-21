extends "res://engine/abilities/continuous_ability.gd"

# preloads
const PassBehaviorBase = preload("res://engine/dungobj/behaviors/pass_behavior_base.gd")
const PassBehaviorTunnel = preload("res://engine/dungobj/behaviors/pass_behavior_tunnel.gd")

func _init(ability_dict).(ability_dict):
    pass

# public functions
func on_dimension():
    summon.pass_behavior = PassBehaviorTunnel.new()

func disable():
    .disable()
    summon.pass_behavior = PassBehaviorBase.new()
