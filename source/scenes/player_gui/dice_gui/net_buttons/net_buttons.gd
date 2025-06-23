extends PanelContainer

#region public variables
var playergui
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
	playergui.net.type = button.type
	if playergui.state == Globals.GUISTATE.DIMENSION:
		Globals.dungeon.set_dimnet(playergui.net)
#endregion
