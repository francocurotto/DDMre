extends PanelContainer

#region private variables
var button_group = ButtonGroup.new()
#endregion

#region builtin functions
func _ready() -> void:
	for button in %GridContainer.get_children():
		button.button_group = button_group
	Net.type = button_group.get_pressed_button().type
	button_group.pressed.connect(on_button_pressed)
#endregion

#region signals callbacks
func on_button_pressed(button):
	Net.type = button.type
#endregion
