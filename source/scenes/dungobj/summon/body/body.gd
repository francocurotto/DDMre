@tool
extends Node3D

#region public functions
func set_material(material):
	get_child(0).set_surface_override_material(0, material)

func set_pre_dimension():
	%Icon1.modulate.a = 0.0
	%Icon2.modulate.a = 0.0

func tween_dimension(tween, summon_time):
	tween.tween_property(%Icon1, "modulate:a", 1.0, summon_time)
	tween.tween_property(%Icon2, "modulate:a", 1.0, summon_time)
#endregion 
