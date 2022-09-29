extends PanelContainer

# variables
var player
var selected_itile

# signals
signal dmenu_move_pressed(itile)
signal dmenu_attack_pressed(itile)
signal dmenu_cancel_pressed

# onready variables
onready var move_button = $ButtonCont/MoveButton
onready var attack_button = $ButtonCont/AttackButton

# setget functions
func set_dungeon_menu(_player):
    player = _player

func enable(itile):
    # enable movement button
    if player.crestpool.slots["MOVEMENT"]:
        selected_itile = itile
        move_button.disabled = false
    if player.crestpool.slots["ATTACK"] and not itile.tile.content.cooldown:
        selected_itile = itile
        attack_button.disabled = false
    visible = true

func disable():
    visible = false

# signal callbacks
func _on_MoveButton_pressed():
    emit_signal("dmenu_move_pressed", selected_itile)

func _on_AttackButton_pressed():
    emit_signal("dmenu_attack_pressed", selected_itile)

func _on_CancelButton_pressed():
    emit_signal("dmenu_cancel_pressed")
