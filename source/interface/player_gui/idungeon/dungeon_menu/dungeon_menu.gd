extends PanelContainer

# variables
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
func set_dungeon_menu(_itile, player):
    itile = _itile
    set_buttons(player)
    emit_signal("dmenu_enabled")

func set_buttons(player):
    if player.crestpool.slots["MOVEMENT"]:
        move_button.disabled = false
    if player.crestpool.slots["ATTACK"] and not itile.tile.content.cooldown:
        attack_button.disabled = false

func enable():
    visible = true

func disable():
    visible = false

# signals callbacks
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

