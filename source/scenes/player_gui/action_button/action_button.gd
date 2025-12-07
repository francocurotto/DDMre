@tool
extends Button

#region constants
const icons = {
	"ENDTURN" : preload("res://assets/icons/ENDTURN.svg"),
	"CANCEL"  : preload("res://assets/icons/CANCEL.svg"),
	"MOVE"    : preload("res://assets/icons/MOVE.svg"),
	"ATTACK"  : preload("res://assets/icons/ATTR_ATTACK.svg"),
	"GUARD"   : preload("res://assets/icons/ATTR_DEFENSE.svg"),
	"WAIT"    : preload("res://assets/icons/WAIT.svg"),
}
const COLORS_NORMAL = {
	"ENDTURN" : Color(0.6, 0.6, 0.6),
	"CANCEL"  : Color(0.4, 0.4, 0.4),
	"MOVE"    : Color(0.3, 0.3, 0.7),
	"ATTACK"  : Color(0.7, 0.3, 0.3),
	"GUARD"   : Color(0.3, 0.7, 0.3),
	"WAIT"    : Color(0.8, 0.8, 0.2),
}

const COLORS_PRESSED = {
	"ENDTURN" : Color(0.3, 0.3, 0.3),
	"CANCEL"  : Color(0.1, 0.1, 0.1),
	"MOVE"    : Color(0.1, 0.1, 0.5),
	"ATTACK"  : Color(0.5, 0.1, 0.1),
	"GUARD"   : Color(0.1, 0.5, 0.1),
	"WAIT"    : Color(0.6, 0.6, 0.1),
}
#endregion

#region export variables
@export_enum("ENDTURN", "CANCEL", "MOVE", "ATTACK", "GUARD", "WAIT")
var type : String = "ENDTURN" :
	set(_type):
		type = _type
		icon = icons[type]
		change_theme("normal", COLORS_NORMAL)
		change_theme("hover", COLORS_NORMAL)
		change_theme("pressed", COLORS_PRESSED)
#endregion

#region public functions
func add_cost(cost):
	$Cost.text = str(cost)

func disable_cost():
	$Cost.text = ""
#endregion

#region private functions
func change_theme(style_name, colors):
	var style = get_theme_stylebox(style_name)
	style.bg_color = colors[type]
#endregion
