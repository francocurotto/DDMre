extends VBoxContainer

#region signals
signal cancel_button_pressed
signal move_button_pressed
#endregion

#region public variables
func activate(crestpool):
	visible = true
	$MoveButton.disabled = crestpool.sides_dict["MOVEMENT"].amount <= 0
	$AttackButton.disabled = crestpool.sides_dict["ATTACK"].amount <= 0

func deactivate():
	visible = false
#endregion

#region signals callbacks
func _on_cancel_button_pressed() -> void:
	visible = false
	cancel_button_pressed.emit()
	for button in get_children():
		button.disable_cost()

func _on_move_button_pressed() -> void:
	$MoveButton.disabled = true
	$AttackButton.disabled = true
	move_button_pressed.emit()

func on_move_path_selected(move_cost):
	$MoveButton.add_cost(move_cost)
	$MoveButton.disabled = false
#endregion
