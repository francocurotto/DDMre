extends VBoxContainer

# variables
var player
var engine

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
func set_dungeon_buttons(_player, _engine):
    player = _player
    engine = _engine

# public functions
func disable_action_buttons():
    for button in action_buttons.get_children():
        button.disabled = true

func switch_to_cancel_button():
    action_buttons.visible = false
    cancel_button.visible = true

func switch_to_action_buttons():
    action_buttons.visible = true
    cancel_button.visible = false

# signals callbacks
func on_tile_select_button_toggled(dungobj, pressed):
    var actionable = dungobj.is_monster() and dungobj.player == player and engine.state.NAME == "DUNGEON" and pressed
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
    disable_action_buttons()
    emit_signal("endturn_button_pressed")

func _on_CancelButton_pressed():
    switch_to_action_buttons()
    move_button.disabled = true
    attack_button.disabled = true
    emit_signal("cancel_button_pressed")
