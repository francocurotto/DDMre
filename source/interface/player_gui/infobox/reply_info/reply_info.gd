extends MarginContainer

# onready variables
onready var attackinfo = $ReplyBox/AttackInfo

# signals
signal guard_input
signal wait_input

# set functions
func set_reply(reply_state):
    attackinfo.set_attack(reply_state.attacker, reply_state.attacked)

# signals callback
func _on_GuardButton_pressed():
    emit_signal("guard_input")

func _on_WaitButton_pressed():
    emit_signal("wait_input")
