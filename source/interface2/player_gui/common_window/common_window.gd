extends HBoxContainer

# onready variables
onready var menu_bar = $MenuBar
onready var players_info = $PlayersInfo

# setget functions
func set_players_info(player, opponent):
    players_info.set_players_info(player, opponent)

# public functions
func update_state(state_name):
    menu_bar.update_state(state_name)
