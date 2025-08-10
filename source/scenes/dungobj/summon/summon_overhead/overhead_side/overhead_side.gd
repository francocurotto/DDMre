@tool
extends Node3D

#region export variables
@export var alpha : float = 1.0 :
	set(_alpha):
		alpha = _alpha
		$Attack.alpha = alpha
		$Defense.alpha = alpha
		$Health.alpha = alpha
#endregion

#region public functions
func set_attack(original_attack, attack):
	$Attack.set_value(original_attack, attack)

func set_defense(original_defense, defense):
	$Defense.set_value(original_defense, defense)

func set_health(original_health, health):
	$Health.set_value(original_health, health)
#endregion
