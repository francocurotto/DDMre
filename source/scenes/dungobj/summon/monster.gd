@tool
extends "summon.gd"

#region public variables
func set_summon(dice_dict, _player):
	summon_name = dice_dict["NAME"]
	level = dice_dict["LEVEL"]
	original_attack = dice_dict["ATTACK"]
	original_defense = dice_dict["DEFENSE"]
	original_health = dice_dict["HEALTH"]
	player = _player
	set_pre_dimension()
#endregion
