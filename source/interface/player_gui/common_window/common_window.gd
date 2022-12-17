extends HBoxContainer

# onready variables
onready var players_info = $PlayersInfo

# signals
signal window_button_pressed

# setget functions
func set_players_info(player, opponent):
    players_info.set_players_info(player, opponent)

# signals callbacks
func _on_WindowButton_pressed():
    emit_signal("window_button_pressed")
