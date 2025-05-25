extends PanelContainer

#region signals
signal roll_changed
#endregion

#region public variables
var buttons = []
var roll_dice_buttons = []
#endregion

#region builtin functions
func _ready() -> void:
	Events.roll_started.connect(on_roll_started)
	for button in $Grid.get_children():
		buttons.append(button)
		button.button_toggled.connect(on_dice_button_toggled)
#endregion

#region public functions
func set_dice(i, dice_dict):
	$Grid.get_child(i).set_dice(dice_dict)
#endregion

#region signals callbacks
func on_dice_button_toggled(toggled_on, button):
	if toggled_on:
		on_dice_button_pressed(button)
	else:
		on_dice_button_released(button)

func on_dice_button_pressed(pressed_button):
	roll_dice_buttons.append(pressed_button)
	if len(roll_dice_buttons) >= 3:
		for button in buttons:
			if button not in roll_dice_buttons:
				button.disabled = true
	roll_changed.emit(roll_dice_buttons)

func on_dice_button_released(released_button):
	roll_dice_buttons.erase(released_button)
	for button in buttons:
		button.disabled = false
	roll_changed.emit(roll_dice_buttons)

func on_roll_started():
	for button in buttons:
		button.disabled = true
#endregion
