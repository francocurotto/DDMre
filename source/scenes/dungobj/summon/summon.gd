extends Node3D

#region public variables
var summon_name : String = ""
var type : String = ""
var level : int = 0
var attack : int = 0
var defense : int = 0
var health : int = 0
var original_attack : int = 0 :
	set(_original_attack):
		original_attack = _original_attack
		attack = original_attack
var original_defense : int = 0 :
	set(_original_defense):
		original_defense = _original_defense
		defense = original_defense
var original_health : int = 0 :
	set(_original_health):
		original_health = _original_health
		health = original_health
#endregion

#region public functions
func set_summon(dice_dict):
	summon_name = dice_dict["NAME"]
	type = dice_dict["TYPE"]
	level = dice_dict["LEVEL"]
	if type != "ITEM":
		original_attack = dice_dict["ATTACK"]
		original_defense = dice_dict["DEFENSE"]
		original_health = dice_dict["HEALTH"]
	$Overheads/SummonOverhead.alpha = 0.0
#endregion
