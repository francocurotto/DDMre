@tool
extends Node3D

#region export variables
@export var alpha : float = 1.0 :
	set(_alpha):
		alpha = _alpha
		$Attack/AttackIcon.modulate.a = alpha
		$Attack/AttackValue.modulate.a = alpha
		$Attack/AttackValue.outline_modulate.a = alpha
		$Defense/DefenseIcon.modulate.a = alpha
		$Defense/DefenseValue.modulate.a = alpha
		$Defense/DefenseValue.outline_modulate.a = alpha
		for heart in $Health.get_children():
			heart.modulate.a = alpha
#endregion
