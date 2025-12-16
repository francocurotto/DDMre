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
const themes = {
	"ENDTURN" : preload("res://assets/themes/endturn_button.tres"),
	"CANCEL"  : preload("res://assets/themes/cancel_button.tres"),
	"MOVE"    : preload("res://assets/themes/move_button.tres"),
	"ATTACK"  : preload("res://assets/themes/attack_button.tres"),
	"GUARD"   : preload("res://assets/themes/guard_button.tres"),
	"WAIT"    : preload("res://assets/themes/wait_button.tres"),
}
#endregion

#region export variables
@export_enum("ENDTURN", "CANCEL", "MOVE", "ATTACK", "GUARD", "WAIT")
var type : String = "ENDTURN" :
	set(_type):
		type = _type
		icon = icons[type]
		theme = themes[type]

@export var cost_enabled : bool = false :
	get():
		return $Cost.visible
	set(_cost_enabled):
		$Cost.visible = _cost_enabled

@export var cost : int = 0 :
	get():
		return int($Cost.text)
	set(_cost):
		$Cost.text = str(_cost)
		cost_enabled = true
#endregion
