extends VBoxContainer

# onready variables
onready var menu_bar = $MenuBar

# public functions
func update_state(state_name):
    menu_bar.update_state(state_name)
