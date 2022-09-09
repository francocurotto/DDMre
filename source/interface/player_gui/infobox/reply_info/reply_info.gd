extends MarginContainer

# variables
var enabled = false

# onready variables
onready var attacker_name = $ReplyBox/AttackerName
onready var attacked_name = $ReplyBox/AttackedName

# signals
signal guard_input
signal wait_input

# set functions
func set_reply(_reply_state):
    pass

# signals callback
func _on_GuardButton_pressed():
    emit_signal("guard_input")

func _on_WaitButton_pressed():
    emit_signal("wait_input")
