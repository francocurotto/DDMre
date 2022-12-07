extends HBoxContainer

# onready variables
onready var dice_triplet = $DiceTriplet
onready var roll_button = $RollButton
onready var skip_button = $SkipButton

# signals
signal roll_button_pressed
signal skip_button_pressed

# public functions
func update_dice_triplet(idicepool):
    dice_triplet.update_dice(idicepool)
    if idicepool.roll_ready():
        roll_button.disabled = false

func disable_roll():
    roll_button.disabled = true

# signals callbacks
func on_dice_dim_button_pressed(_dice):
    skip_button.disabled = true

func on_dice_dim_button_released():
    skip_button.disabled = false

func _on_RollButton_pressed():
    emit_signal("roll_button_pressed")

func _on_SkipButton_pressed():
    switch_to_roll_button()
    emit_signal("skip_button_pressed")

# private functions
func switch_to_skip_button():
    skip_button.visible = true
    roll_button.visible = false

func switch_to_roll_button():
    roll_button.visible = true
    skip_button.visible = false
