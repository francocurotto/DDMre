extends VBoxContainer

# onready variables
onready var player_info = $PlayerPanel/PlayerInfo
onready var opponent_info = $OpponentPanel/OpponentInfo

# setget functions
func set_players_info(player, opponent):
    player_info.set_player_info(player)
    opponent_info.set_player_info(opponent)
