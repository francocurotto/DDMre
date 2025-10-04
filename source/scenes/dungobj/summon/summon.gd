@tool
extends StaticBody3D

#region constants
const SUMMON_TIME = 1.0
#endregion

#region export variables
@export_range(1, 2, 1) var player : int = 1 :
	set(_player):
		player = _player
		var material = Globals.PLAYER_MATERIALS[player].duplicate()
		$BaseMesh.set_surface_override_material(0, material)
		$BodyMesh.set_material(material)

@export_range(0, 50, 10) var original_attack : int = 10 :
	set(_original_attack):
		original_attack = _original_attack
		attack = original_attack
		$SummonOverhead.set_attack(original_attack, attack)

@export_range(0, 50, 10) var original_defense : int = 10 :
	set(_original_defense):
		original_defense = _original_defense
		defense = original_defense
		$SummonOverhead.set_defense(original_defense, defense)

@export_range(0, 60, 10) var original_health : int = 10 :
	set(_original_health):
		original_health = _original_health
		health = original_health
		$SummonOverhead.set_health(original_health, health)

@export_range(0, 90, 10) var attack : int = 10 :
	set(_attack):
		attack = _attack
		$SummonOverhead.set_attack(original_attack, attack)

@export_range(0, 90, 10) var defense : int = 10 :
	set(_defense):
		defense = _defense
		$SummonOverhead.set_defense(original_defense, defense)

@export_range(0, 60, 10) var health : int = 10 :
	set(_health):
		health = _health
		$SummonOverhead.set_health(original_health, health)
#endregion

#region public variables
var summon_name : String = ""
var level : int = 0
#endregion

#region public variables
func tween_dimension(tween):
	var material = $BaseMesh.get_surface_override_material(0)
	tween.tween_property(material, "emission_energy_multiplier", 0.0, SUMMON_TIME)
	tween.set_parallel(true)
	tween.tween_property($SummonOverhead, "alpha", 1.0, SUMMON_TIME)
	$BodyMesh.tween_dimension(tween, SUMMON_TIME)
#endregion

#region private functions
func set_pre_dimension():
	var material = $BaseMesh.get_surface_override_material(0)
	material.emission_energy_multiplier = 2.0
	$SummonOverhead.alpha = 0.0
	$BodyMesh.set_pre_dimension()
#endregion
