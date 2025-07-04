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
	%Dicepool.roll_dice_added.connect(on_roll_dice_added)
	%Dicepool.roll_dice_removed.connect(on_roll_dice_removed)
	%Rollzone.crest_side_rolled.connect($Crestpool.on_crest_side_rolled)
#endregion

#region public functions
func set_dice(i, dice):
	%Dicepool.set_dice(i, dice)
#endregion

#region signals callback
func on_roll_dice_added(n_buttons_pressed, dice):
	tab_bar.set_tab_title(1, "Rollzone (%d/3)" % n_buttons_pressed)
	%Rollzone.add_dice(dice)

func on_roll_dice_removed(selected_dice_list):
	tab_bar.set_tab_title(1, "Rollzone (%d/3)" % len(selected_dice_list))
	%Rollzone.remove_dice(selected_dice_list)

func _on_tab_container_tab_changed(_tab: int) -> void:
	dicegui_tab_changed.emit()
	var current_control_tab = $TabContainer.get_current_tab_control()
	%Rollzone.controls.disabled = current_control_tab != %Rollzone
#endregion
