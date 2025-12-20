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
#endregion

#region public functions
func set_crestpool(crest_dict):
	for crest in crest_dict:
		sides_dict[crest].amount = crest_dict[crest]
#endregion

#region signals callbacks
func on_crest_side_rolled(side):
	sides_dict[side.crest].add_crest(side.mult)

func on_monster_moved(cost):
	sides_dict["MOVEMENT"].remove_crest(cost)
#endregion
