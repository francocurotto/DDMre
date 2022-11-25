extends HBoxContainer

# variables
var player
var activated = false

# signals
signal endturn_button_pressed

# onready variables
onready var move_button = $MoveButton
onready var attack_button = $AttackButton
onready var endturn_button = $EndTurnButton

# setget functions
func set_player(_player):
    player = _player

# public functions
func activate():
    activated = true
    endturn_button.disabled = false

func deactivate():
    activated = false
    endturn_button.disabled = true

# signals callbacks
func on_tile_button_toggled(dungobj, pressed):
    var actionable = dungobj.is_summon() and activated and pressed
    move_button.disabled = !(actionable and player.crestpool.slots["MOVEMENT"]>0)
    attack_button.disabled = !(actionable and player.crestpool.slots["ATTACK"]>0)

func _on_EndTurnButton_pressed():
    emit_signal("endturn_button_pressed")
