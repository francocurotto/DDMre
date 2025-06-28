extends VBoxContainer

#region signals
signal dicegui_tab_changed
#endregion

#region private variables
var tab_bar
#endregion

#region onready variables
@onready var dicepool = %Dicepool
@onready var rollzone = %Rollzone
@onready var net_buttons = %Nets
#endregion

#region builtin functions
func _ready() -> void:
	tab_bar = $TabContainer.get_tab_bar() 
	tab_bar.set_tab_title(1, "Rollzone (0/3)")
	%Dicepool.roll_changed.connect(on_roll_changed)
#endregion

#region public functions
func set_dice(i, dice):
	%Dicepool.set_dice(i, dice)
#endregion

#region signals callback
func on_roll_changed(roll_dice_buttons):
	tab_bar.set_tab_title(1, "Rollzone (%d/3)" % len(roll_dice_buttons))
	%Rollzone.update_dice(roll_dice_buttons)

func _on_tab_container_tab_changed(_tab: int) -> void:
	dicegui_tab_changed.emit()
	var current_control_tab = $TabContainer.get_current_tab_control()
	%Rollzone.rollzone_tab_selected = current_control_tab == %Rollzone
#endregion
