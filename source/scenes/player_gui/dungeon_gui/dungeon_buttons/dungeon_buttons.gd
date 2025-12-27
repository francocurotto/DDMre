extends VBoxContainer

#region signals
signal cancel_button_pressed
signal move_action_started
signal move_path_confirmed
signal attack_action_started
signal attack_confirmed
#endregion

#region public variables
func activate(crestpool):
	visible = true
	$MoveButton.disabled = crestpool.sides_dict["MOVEMENT"].amount <= 0
	$AttackButton.disabled = crestpool.sides_dict["ATTACK"].amount <= 0

func deactivate():
	visible = false

func get_move_cost():
	return $MoveButton.cost
#endregion

#region signals callbacks
func _on_cancel_button_pressed() -> void:
	visible = false
	cancel_button_pressed.emit()
	for button in get_children():
		button.cost_enabled = false

func _on_move_button_pressed() -> void:
	disable_action_buttons()
	if not $MoveButton.cost_enabled:
		move_action_started.emit()
	else:
		visible = false
		move_path_confirmed.emit()
		$MoveButton.cost_enabled = false

func _on_attack_button_pressed() -> void:
	disable_action_buttons()
	if not $AttackButton.cost_enabled:
		attack_action_started.emit()
	else:
		visible = false
		attack_confirmed.emit()
		$AttackButton.cost_enabled = false

func on_move_path_selected(move_cost):
	$MoveButton.cost = move_cost
	$MoveButton.disabled = false

func on_attack_selected():
	$AttackButton.cost = 1
	$AttackButton.disabled = false
#endregion

#region private functions
func disable_action_buttons():
	$MoveButton.disabled = true
	$AttackButton.disabled = true
#endregion
