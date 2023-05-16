extends PanelContainer

# onready variables
onready var roll_info = $RollGUIVBox/RollGUIHBox/RollInfo
onready var roll_button = $RollGUIVBox/RollGUIHBox/RollButton
onready var skip_button = $RollGUIVBox/RollGUIHBox/SkipButton

# signals
signal roll_gui_roll_button_pressed
signal roll_gui_skip_button_pressed

# public functions
func reset():
    roll_info.reset()
    switch_to_roll_button()
    skip_button.disabled = false

func disable_roll():
    roll_button.disabled = true

func set_roll(sides):
    roll_info.set_roll(sides)

# signals callbacks
func on_dicepool_gui_changed(dicepool_gui):
    roll_info.update_dice(dicepool_gui)
    if dicepool_gui.roll_ready():
        roll_button.disabled = false

func on_dice_gui_dim_button_pressed(_dice):
    skip_button.disabled = true

func on_dice_gui_dim_button_released():
    skip_button.disabled = false

func _on_RollButton_pressed():
    emit_signal("roll_gui_roll_button_pressed")

func _on_SkipButton_pressed():
    switch_to_roll_button()
    emit_signal("roll_gui_skip_button_pressed")

# private functions
func switch_to_skip_button():
    skip_button.visible = true
    roll_button.visible = false

func switch_to_roll_button():
    roll_button.visible = true
    skip_button.visible = false
