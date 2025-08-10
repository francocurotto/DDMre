@tool
extends Node3D

#region export variables
@export_range(1, 2, 1) var player : int = 1 :
	set(_player):
		player = _player
		var player_material = Globals.PLAYER_MATERIALS[player]
		$Base.set_surface_override_material(0, player_material)
		$Body.set_surface_override_material(0, player_material)

@export_enum("DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR")
var type : String = "DRAGON" :
	set(_type):
		type = _type
		$Body/Icon1.texture = load("res://assets/SUMMON_%s.svg" % type)
		$Body/Icon2.texture = load("res://assets/SUMMON_%s.svg" % type)
		$SummonOverhead.visible = type != "ITEM"

@export_range(0, 50, 10) var original_attack : int = 0 :
	set(_original_attack):
		original_attack = _original_attack
		attack = original_attack
		$SummonOverhead.set_attack(original_attack, attack)

@export_range(0, 50, 10) var original_defense : int = 0 :
	set(_original_defense):
		original_defense = _original_defense
		defense = original_defense
		$SummonOverhead.set_defense(original_defense, defense)

@export_range(0, 60, 10) var original_health : int = 0 :
	set(_original_health):
		original_health = _original_health
		health = original_health
		$SummonOverhead.set_health(original_health, health)

@export_range(0, 90, 10) var attack : int = 0 :
	set(_attack):
		attack = _attack
		$SummonOverhead.set_attack(original_attack, attack)

@export_range(0, 90, 10) var defense : int = 0 :
	set(_defense):
		defense = _defense
		$SummonOverhead.set_defense(original_defense, defense)

@export_range(0, 60, 10) var health : int = 0 :
	set(_health):
		health = _health
		$SummonOverhead.set_health(original_health, health)
#endregion

#region public variables
var summon_name : String = ""
var level : int = 0
#endregion

#region public functions
func set_summon(dice_dict, _player):
	summon_name = dice_dict["NAME"]
	type = dice_dict["TYPE"]
	level = dice_dict["LEVEL"]
	if type != "ITEM":
		original_attack = dice_dict["ATTACK"]
		original_defense = dice_dict["DEFENSE"]
		original_health = dice_dict["HEALTH"]
	player = _player
	$SummonOverhead.alpha = 0.0
#endregion
