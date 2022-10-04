extends PanelContainer

# variables
var player
var itile

# signals
signal dmenu_move_pressed(itile)
signal dmenu_attack_pressed(itile)
signal dmenu_cancel_pressed
signal dmenu_enabled

# onready variables
onready var move_button = $ButtonCont/MoveButton
onready var attack_button = $ButtonCont/AttackButton

# setget functions
func set_dungeon_menu(_player, _itile):
    player = _player
    itile = _itile
    set_buttons()

func set_buttons():
    # enable movement button
    if player.crestpool.slots["MOVEMENT"]:
        move_button.disabled = false
    if player.crestpool.slots["ATTACK"] and not itile.tile.content.cooldown:
        attack_button.disabled = false

func enable():
    visible = true

func disable():
    visible = false

# public functions
func connect_idungeon_signals(idungeon):
    connect("dmenu_move_pressed", idungeon, "on_dmenu_move_pressed")
    connect("dmenu_attack_pressed", idungeon, "on_dmenu_attack_pressed")
    connect("dmenu_cancel_pressed", idungeon, "on_dmenu_cancel_pressed")
    connect("dmenu_enabled", idungeon, "on_dmenu_enabled")

# signal callbacks
func _on_MoveButton_pressed():
    emit_signal("dmenu_move_pressed", itile)

func _on_AttackButton_pressed():
    emit_signal("dmenu_attack_pressed", itile)

func _on_CancelButton_pressed():
    emit_signal("dmenu_cancel_pressed")

func _input(event):
    if event.is_action_released("ui_cancel"):
        if visible:
            emit_signal("dmenu_cancel_pressed")
        else:
            visible = true
            emit_signal("dmenu_enabled")
