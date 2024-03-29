extends VBoxContainer

# variables
var player
var engine

# signals
signal move_button_pressed
signal attack_button_pressed
signal ability_button_pressed
signal jump_button_pressed
signal endturn_button_pressed
signal cancel_button_pressed
signal back_button_pressed

# onready variables
onready var action_buttons = $ActionButtons
onready var move_button = $ActionButtons/MoveButton
onready var attack_button = $ActionButtons/AttackButton
onready var ability_button = $ActionButtons/AbilityButton
onready var jump_button = $ActionButtons/JumpButton
onready var endturn_button = $ActionButtons/EndTurnButton
onready var cancel_button = $CancelButton
onready var back_button = $BackButton

# setget functions
func set_dungeon_buttons(_player, _engine):
    player = _player
    engine = _engine

# public functions
func disable_action_buttons():
    for button in action_buttons.get_children():
        button.disabled = true

func hide_all_buttons():
    for buttons in get_children():
        buttons.visible = false

func switch_to_action_buttons():
    hide_all_buttons()
    action_buttons.visible = true
    
func switch_to_cancel_button():
    hide_all_buttons()
    cancel_button.visible = true

func switch_to_back_button():
    hide_all_buttons()
    back_button.visible = true

# signals callbacks
func on_tile_select_button_toggled(tile, pressed):
    var dungobj = tile.content
    var actionable = dungobj.is_monster() and dungobj.player == player and engine.state.NAME == "DUNGEON" and pressed
    move_button.disabled = !(actionable and player.crestpool.movement>0 and dungobj.max_move>0)
    attack_button.disabled = !(actionable and player.crestpool.attack>=dungobj.attack_cost and dungobj.attack_cooldown_behavior.can_attack())
    ability_button.disabled = !(actionable and dungobj.has_active_standing_ability() and not dungobj.ability_cooldown)
    jump_button.disabled = !(actionable and dungobj.tile.vortex)
    jump_button.visible = !jump_button.disabled
    
func on_menu_opened():
    cancel_button.disabled = true

func _on_MoveButton_pressed():
    switch_to_cancel_button()
    emit_signal("move_button_pressed")

func _on_AttackButton_pressed():
    switch_to_cancel_button()
    emit_signal("attack_button_pressed")

func _on_AbilityButton_pressed():
    disable_action_buttons()
    emit_signal("ability_button_pressed")

func _on_JumpButton_pressed():
    switch_to_cancel_button()
    emit_signal("jump_button_pressed")

func _on_EndTurnButton_pressed():
    disable_action_buttons()
    emit_signal("endturn_button_pressed")

func _on_CancelButton_pressed():
    switch_to_action_buttons()
    move_button.disabled = true
    attack_button.disabled = true
    jump_button.disabled = true
    jump_button.visible = false
    emit_signal("cancel_button_pressed")

func _on_BackButton_pressed():
    switch_to_action_buttons()
    emit_signal("back_button_pressed")
