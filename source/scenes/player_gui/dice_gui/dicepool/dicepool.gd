extends PanelContainer

#region signals
signal roll_dice_added
signal roll_dice_removed
signal dice_button_focused
#endregion

#region public variables
var player_gui
var buttons = []
var n_buttons_pressed : int = 0 :
	get():
		var counter = 0
		for button in buttons:
			if button.pressed:
				counter += 1
		return counter
#endregion

#region builtin functions
func _ready() -> void:
	player_gui = find_parent("PlayerGUI?")
	for button in $Grid.get_children():
		buttons.append(button)
		button.button_focused.connect(on_dice_button_focused)
		button.button_toggled.connect(on_dice_button_toggled)
#endregion

#region public functions
func set_dice(i, dice_dict, player):
	$Grid.get_child(i).set_dice(i, dice_dict, player)

func enable_dice_buttons():
	for button in buttons:
		if button.available:
			button.disabled = false
#endregion

#region signals callbacks
func on_dice_button_focused(dice):
	dice_button_focused.emit(dice)

func on_dice_button_toggled(toggled_on, button):
	if toggled_on:
		on_dice_button_pressed(button)
	else:
		on_dice_button_released()

#func on_roll_started():
func disable_buttons():
	for button in buttons:
		button.disabled = true

func on_dimension_started(dimdice):
	for button in buttons:
		button.pressed = false
		if button.dice.index == dimdice.index:
			button.available = false

func on_switched_to_roll_state():
	# case there was a dimension in previous turn
	if buttons.any(func(button): return button.pressed):
		for button in buttons:
			if button.pressed:
				button.disabled = false
				button._on_button_toggled(true)
	# case there was no dimension in previous turn
	else:
		enable_dice_buttons()
#endregion

#region private functions
func on_dice_button_pressed(pressed_button):
	if n_buttons_pressed >= 3:
		for button in buttons:
			if not button.pressed:
				button.disabled = true
	roll_dice_added.emit(n_buttons_pressed, pressed_button.dice)

func on_dice_button_released():
	var selected_dice_list = []
	for button in buttons:
		if button.available:
			button.disabled = false
		if button.pressed:
			selected_dice_list.append(button.dice)
	roll_dice_removed.emit(selected_dice_list)
#endregion
