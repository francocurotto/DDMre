@tool
extends AspectRatioContainer

#region constants
const DICE_ANGULAR_VELOCITY = 2
#endregion

#region signals
signal button_focused
signal button_toggled
#endregion

#region export variables
@export var disabled : bool = false :
	set(_disabled):
		disabled = _disabled
		%Button.disabled = disabled
		%SubViewportContainer.modulate.a = 1-0.7*int(disabled)

@export var available : bool = true :
	set(_available):
		available = _available
		%Dice.dimensioned = not available
		%Dice.angular_velocity.z = int(available) * DICE_ANGULAR_VELOCITY
#endregion

#region public variables
var pressed : bool = false :
	get():
		return %Button.button_pressed
	set(_pressed):
		%Button.set_pressed_no_signal(_pressed)
#endregion

#region onready variables
@onready var dice = %Dice
#endregion

#region public functions
func set_dice(index, dice_dict, player):
	%Dice.set_dice(index, dice_dict, player)
	%Dice.angular_velocity.z = DICE_ANGULAR_VELOCITY
#endregion

#region signals callbacks
func _on_button_mouse_entered() -> void:
	%Button.grab_focus()

func _on_button_toggled(toggled_on: bool) -> void:
	button_toggled.emit(toggled_on, self)

func _on_button_focus_entered() -> void:
	button_focused.emit(%Dice)
#endregion
