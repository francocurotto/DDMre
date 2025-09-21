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
	%Rollzone.roll_started.connect(on_roll_started)
	%Rollzone.crest_side_rolled.connect($Crestpool.on_crest_side_rolled)
#endregion

#region public functions
func set_dice(i, dice, player):
	%Dicepool.set_dice(i, dice, player)
#endregion

#region signals callback
func on_roll_dice_added(n_buttons_pressed, dice):
	tab_bar.set_tab_title(1, "Rollzone (%d/3)" % n_buttons_pressed)
	%Rollzone.add_dice(dice)

func on_roll_dice_removed(selected_dice_list):
	tab_bar.set_tab_title(1, "Rollzone (%d/3)" % len(selected_dice_list))
	%Rollzone.remove_dice(selected_dice_list)

func on_roll_started():
	tab_bar.set_tab_title(1, "Rollzone (0/3)")
	%Dicepool.on_roll_started()

func _on_tab_container_tab_changed(_tab: int) -> void:
	if is_node_ready(): # needed to avoid godot 4.5 error
		dicegui_tab_changed.emit()
		var current_control_tab = $TabContainer.get_current_tab_control()
		%Rollzone.controls.disabled = current_control_tab != %Rollzone

func on_dimension_started(dimdice):
	%Dicepool.on_dimension_started(dimdice)
	%Rollzone.on_dimension_started()
	%Nets.disable_buttons()

func on_switched_to_roll_state():
	$TabContainer.current_tab = 0
	%Dicepool.on_switched_to_roll_state()
	%Nets.enable_buttons()
#endregion
