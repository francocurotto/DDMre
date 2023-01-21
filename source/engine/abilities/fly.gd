extends "base_ability.gd"

# preloads
const PassBehaviorFly = preload("res://engine/dungobj/behaviors/pass_behavior_fly.gd")
const TargetBehaviorFly = preload("res://engine/dungobj/behaviors/target_behavior_fly.gd")

func _init(ability_dict).(ability_dict):
    pass

# public functions
func on_summon(monster):
    monster.pass_behavior = PassBehaviorFly.new()
    monster.target_behavior = TargetBehaviorFly.new(monster.player)
