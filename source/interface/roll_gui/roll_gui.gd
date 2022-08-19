tool
extends HBoxContainer

# onready variables
onready var roll_button = $PlayerPanel/BPBox/RollButton
onready var player_roll = $PlayerPanel/BPBox/PlayerRoll
onready var opponent_roll = $OppPanel/LOBox/OppRoll
onready var endturn_button = $EndTurnButton

# signals
signal roll_pressed
signal endturn_pressed

# set functions
func set_roll_button(enable):
    roll_button.disabled = not enable

func update_roll_player(sides):
    player_roll.set_roll(sides)
    player_roll.show_roll(true)

func update_roll_opponent(sides):
    opponent_roll.set_roll(sides)
    opponent_roll.show_roll(true)

func enable_roll():
    roll_button.disabled = false
    
func disable_roll():
    roll_button.disabled = true
    
func enable_endturn():
    endturn_button.disabled = false

func disable_endturn():
    endturn_button.disabled = true

func hide_rolls():
    player_roll.show_roll(false)
    opponent_roll.show_roll(false)

func hide_player_roll():
    player_roll.show_roll(false)

# signals callback
func _on_RollButton_pressed():
    emit_signal("roll_pressed")
    
func _on_EndTurnButton_pressed():
    emit_signal("endturn_pressed")
