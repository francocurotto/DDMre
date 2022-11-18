extends HBoxContainer

# onready variables
onready var duel_info = $DuelInfo

# public functions
func update_state(state_name):
    duel_info.update_state(state_name)
