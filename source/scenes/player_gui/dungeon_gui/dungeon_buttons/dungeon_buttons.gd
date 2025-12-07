extends VBoxContainer

#region signals
signal cancel_button_pressed
signal move_action_started
signal move_path_confirmed
#endregion

#region public variables
func activate(crestpool):
	visible = true
	$MoveButton.disabled = crestpool.sides_dict["MOVEMENT"].amount <= 0
	$AttackButton.disabled = crestpool.sides_dict["ATTACK"].amount <= 0

func deactivate():
	visible = false

func get_move_cost():
	return $MoveButton.get_cost()
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
	if not $MoveButton.has_cost():
		move_action_started.emit()
	else:
		visible = false
		move_path_confirmed.emit()
		$MoveButton.disable_cost()

func on_move_path_selected(move_cost):
	$MoveButton.add_cost(move_cost)
	$MoveButton.disabled = false
#endregion
