extends PanelContainer

#region public variables
var player_gui
#endregion

#region private variables
var button_group = ButtonGroup.new()
#endregion

#region builtin functions
func _ready() -> void:
	for button in %GridContainer.get_children():
		button.button_group = button_group
	button_group.pressed.connect(on_button_pressed)
#endregion

#region signals callbacks
func on_button_pressed(button):
	player_gui.net.type = button.type
	if player_gui.guistate == Globals.GUISTATE.DIMENSION:
		Globals.dungeon.set_dimnet(player_gui.net)
#endregion
