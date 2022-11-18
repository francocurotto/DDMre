extends PanelContainer

# onready variables
onready var phase =  $HBox/Phase

# public functions
func update_state(state_name):
    phase.text = state_name
