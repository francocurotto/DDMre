extends HBoxContainer

# onready variables
onready var dice_triplet = $DiceTriplet
onready var roll_button = $RollButton

# signals
signal roll_input

# setget functions
func set_roll(sides):
    dice_triplet.set_roll(sides)

# public functions
func update_roll_triplet(idicepool):
    dice_triplet.update_dice(idicepool)
    if idicepool.roll_ready():
        roll_button.disabled = false

func disable_roll():
    roll_button.disabled = true

# signals callbacks
func _on_RollButton_pressed():
    emit_signal("roll_input")
