extends VBoxContainer

#region public variables
var state : 
	set(_state):
		state = _state
		%Rollzone.state = state
#endregion

#region builtin functions
func _ready() -> void:
	$TabContainer.get_tab_bar().set_tab_title(2, "Rollzone (0/3)")
	%Dicepool.roll_changed.connect(on_roll_changed)
#endregion

#region public functions
func set_dice(i, dice):
	%Dicepool.set_dice(i, dice)
#endregion

#region signals callback
func on_roll_changed(roll_dice_buttons):
	$TabContainer.get_tab_bar().set_tab_title(2, "Rollzone (%d/3)" % len(roll_dice_buttons))
	%Rollzone.update_dice(roll_dice_buttons)

func _on_tab_container_tab_changed(_tab: int) -> void:
	Events.dicegui_tab_changed.emit()
#endregion
