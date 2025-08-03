extends Node3D

#region public variables
var summon_name : String = ""
var type : String = ""
var level : int = 0
var attack : int = 0
var defense : int = 0
var health : int = 0
#endregion

#region public functions
func set_summon(dice_dict):
	summon_name = dice_dict["NAME"]
	type = dice_dict["TYPE"]
	level = dice_dict["LEVEL"]
	if type != "ITEM":
		attack = dice_dict["ATTACK"]
		defense = dice_dict["DEFENSE"]
		health = dice_dict["HEALTH"]
	$Overheads/SummonOverhead.alpha = 0.0
#endregion
