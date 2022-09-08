extends MarginContainer

# variables
var enabled = false

# onready variables
onready var attacker_name = $ReplyBox/AttackerName
#onready var attacker_stats = $ReplyBox/AttackerStats
onready var attacked_name = $ReplyBox/AttackedName
#onready var attacked_stats = $ReplyBox/AttackedStats

# signals
signal input_guard
signal input_wait

# set functions
func set_reply(_reply_state):
    pass

# signals callback
func _on_GuardButton_pressed():
    emit_signal("input_guard")

func _on_WaitButton_pressed():
    emit_signal("input_wait")
