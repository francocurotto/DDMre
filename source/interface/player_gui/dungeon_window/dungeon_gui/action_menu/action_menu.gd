extends PanelContainer

# onready variables
onready var attack_gui = $VBox/GUIs/AttackGUI
onready var reply_gui = $VBox/GUIs/ReplyGUI

# signals
signal check_dungeon_button_pressed

# public functions
func activate_attack_gui(attacker, attacked):
    attack_gui.activate(attacker, attacked)
    visible = true

func activate_reply_gui(attacker, attacked):
    reply_gui.activate(attacker, attacked)
    visible = true

# signals callbacks
func _on_CheckDungeonButton_pressed():
    emit_signal("check_dungeon_button_pressed")
