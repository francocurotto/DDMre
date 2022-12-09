extends VBoxContainer

# variables
var player
var activated = false

# signals
signal move_button_pressed
signal attack_button_pressed
signal endturn_button_pressed
signal cancel_button_pressed

# onready variables
onready var action_buttons = $ActionButtons
onready var move_button = $ActionButtons/MoveButton
onready var attack_button = $ActionButtons/AttackButton
onready var endturn_button = $ActionButtons/EndTurnButton
onready var cancel_button = $CancelButton

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

func switch_to_cancel_button():
    action_buttons.visible = false
    cancel_button.visible = true

func switch_to_action_buttons():
    action_buttons.visible = true
    cancel_button.visible = false

# signals callbacks
func on_tile_select_button_toggled(dungobj, pressed):
    var actionable = dungobj.is_monster() and dungobj.player == player and activated and pressed
    move_button.disabled = !(actionable and player.crestpool.slots["MOVEMENT"]>0)
    attack_button.disabled = !(actionable and player.crestpool.slots["ATTACK"]>0 and not dungobj.cooldown)

func on_menu_opened():
    cancel_button.disabled = true

func _on_MoveButton_pressed():
    switch_to_cancel_button()
    emit_signal("move_button_pressed")

func _on_AttackButton_pressed():
    switch_to_cancel_button()
    emit_signal("attack_button_pressed")

func _on_EndTurnButton_pressed():
    deactivate()
    emit_signal("endturn_button_pressed")

func _on_CancelButton_pressed():
    switch_to_action_buttons()
    move_button.disabled = true
    attack_button.disabled = true
    emit_signal("cancel_button_pressed")
