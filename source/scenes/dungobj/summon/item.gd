@tool
extends "summon.gd"

#region public functions
var type = "ITEM"
#endregion

#region public variables
func set_summon(dice_dict, _player):
	summon_name = dice_dict["NAME"]
	level = dice_dict["LEVEL"]
	player = _player
	set_pre_dimension()
#endregion
