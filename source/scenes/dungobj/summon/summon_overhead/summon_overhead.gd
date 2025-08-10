@tool
extends Node3D

#region export variables
@export var alpha : float = 1.0 :
	set(_alpha):
		alpha = _alpha
		$OverheadSide1.alpha = alpha
		$OverheadSide2.alpha = alpha
#endregion

#region public functions
func set_attack(original_attack, attack):
	$OverheadSide1.set_attack(original_attack, attack)
	$OverheadSide2.set_attack(original_attack, attack)

func set_defense(original_defense, defense):
	$OverheadSide1.set_defense(original_defense, defense)
	$OverheadSide2.set_defense(original_defense, defense)

func set_health(original_health, health):
	$OverheadSide1.set_health(original_health, health)
	$OverheadSide2.set_health(original_health, health)
#endregion
