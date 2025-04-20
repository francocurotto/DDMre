extends TabContainer

#region builtin functions
func _ready() -> void:
	get_tab_bar().set_tab_title(2, "Roll (0/3)")
	$Dicepool.roll_changed.connect(on_roll_changed)
#endregion

#region public functions
func set_dice(i, dice):
	$Dicepool.set_dice(i, dice)
#endregion

#region signals callback
func on_roll_changed(roll_dice_buttons):
	get_tab_bar().set_tab_title(2, "Roll (%d/3)" % len(roll_dice_buttons))
#endregion
