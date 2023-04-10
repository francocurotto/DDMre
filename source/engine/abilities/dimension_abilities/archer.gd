extends "dimension_ability.gd"

# constants
const TargetBehaviorFly = preload("res://engine/dungobj/behaviors/target_behavior_fly.gd")

func _init(ability_dict).(ability_dict):
    pass

# public functions
func on_dimension():
    monster.target_behavior = TargetBehaviorFly.new()
