extends PanelContainer

# onready variables
onready var turn_count = $LabelBox/TurnCount
onready var state_label = $LabelBox/StateLabel

# signals callback
func on_state_update(state):
    state_label.text = "State: " + state

func on_next_turn(turn):
    turn_count.text = "Turn: " + str(turn)
