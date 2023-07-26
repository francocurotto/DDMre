extends HBoxContainer

# onready variables
onready var player_info = $PlayerInfoVBox/PlayerInfo
onready var opponent_info = $PlayerInfoVBox/OpponentInfo
onready var switch_button = $SwitchButton

# signals
signal switch_button_pressed

# setget functions
func set_players_info(player, opponent):
    player_info.set_player_info(player)
    opponent_info.set_player_info(opponent)

# public functions
func enable_switch_button():
    switch_button.disabled = false

func disable_switch_button():
    switch_button.disabled = true

# signals callbacks
func _on_SwitchButton_pressed():
    emit_signal("switch_button_pressed")
