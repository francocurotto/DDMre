extends "base_ability.gd"

# preloads
const PassBehaviorTunnel = preload("res://engine/dungobj/behaviors/pass_behavior_tunnel.gd")

func _init(ability_dict).(ability_dict):
    pass

# public functions
func on_summon(monster):
    monster.pass_behavior = PassBehaviorTunnel.new()
