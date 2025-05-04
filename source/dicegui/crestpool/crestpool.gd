extends PanelContainer

#region private variables
var sides_dict
#endregion

#region builtin fuctions
func _ready() -> void:
	sides_dict = {
		"MOVEMENT" : $HBoxContainer/Movement,
		"ATTACK"   : $HBoxContainer/Attack,
		"DEFENSE"  : $HBoxContainer/Defense,
		"MAGIC"    : $HBoxContainer/Magic,
		"TRAP"     : $HBoxContainer/Trap,
	}
	Events.crest_side_rolled.connect(on_crest_side_rolled)
	
#endregion

#region signals callbacks
func on_crest_side_rolled(side):
	sides_dict[side.type].add_crest(side.mult)
#endregion
