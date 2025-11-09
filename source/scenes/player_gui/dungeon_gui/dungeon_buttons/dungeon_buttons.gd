extends VBoxContainer

#region signals
signal cancel_button_pressed
#endregion

#region public variables
func activate(crestpool):
	visible = true
	$MoveButton.disabled = crestpool.sides_dict["MOVEMENT"].amount <= 0
	$AttackButton.disabled = crestpool.sides_dict["ATTACK"].amount <= 0
#endregion

#region signals callbacks
func _on_cancel_button_pressed() -> void:
	visible = false
	cancel_button_pressed.emit()
#endregion
