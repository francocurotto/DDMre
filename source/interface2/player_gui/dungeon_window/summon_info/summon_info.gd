extends HBoxContainer

# onready variables
onready var summon_line = $SummonLine
onready var info_button = $InfoButton

# variables
var player

# setget functions
func set_player(_player):
    player = _player

# signals callbacks
func on_tile_button_toggled(dungobj, pressed):
    if pressed and dungobj.is_summon():
        summon_line.set_summon(dungobj, player)
        info_button.set_card(dungobj.card)
        info_button.disabled = dungobj.is_item() and player != dungobj.player
    else:
        summon_line.clear()
        info_button.disabled = true

