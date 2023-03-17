extends PanelContainer

# onready variables
onready var summon_info = $SummonGUIHBox/SummonInfo
onready var info_button = $SummonGUIHBox/InfoButton

# variables
var player
var card

# signals
signal summon_gui_info_button_pressed(card)

# setget functions
func set_player(_player):
    player = _player

# signals callbacks
func on_tile_select_button_toggled(dungobj, pressed):
    if pressed and dungobj.is_summon():
        summon_info.set_summon(dungobj, player)
        card = dungobj.card
        info_button.disabled = dungobj.is_item() and player != dungobj.player
    else:
        summon_info.clear()
        info_button.disabled = true

func _on_InfoButton_pressed():
    emit_signal("summon_gui_info_button_pressed", card)
