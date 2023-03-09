extends "dimension_ability.gd"

# preloads
const PassBehaviorBase = preload("res://engine/dungobj/behaviors/pass_behavior_base.gd")
const PassBehaviorTunnel = preload("res://engine/dungobj/behaviors/pass_behavior_tunnel.gd")

func _init(ability_dict).(ability_dict):
    pass

# public functions
func on_dimension():
    monster.pass_behavior = PassBehaviorTunnel.new()

func disable():
    monster.pass_behavior = PassBehaviorBase.new()
