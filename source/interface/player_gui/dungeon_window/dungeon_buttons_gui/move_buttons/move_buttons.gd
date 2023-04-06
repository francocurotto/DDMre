extends HBoxContainer

# variables
var pos1
var pos2

# onready variables
onready var move_button = $MoveButton

# singals
signal move_buttons_move_button_pressed
signal move_buttons_cancel_button_pressed

# public functions
func activate(_pos1, _pos2, move_cost):
    pos1 = _pos1
    pos2 = _pos2
    move_button.text = "⬆MOVE (%d⬆)" % move_cost

# signals callbacks
func _on_MoveButton_pressed():
    emit_signal("move_buttons_move_button_pressed", pos1, pos2)

func _on_CancelButton_pressed():
    emit_signal("move_buttons_cancel_button_pressed")
