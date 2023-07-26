extends HBoxContainer

# variables
var tiles
var max_summons
var selected_tile
var poslist = []

# onready variables
onready var select_button = $SelectButton

# signals
signal select_summons_done_button_pressed

# public functions
func initialize(_tiles, _max_summons, selected_tile_gui):
    tiles = _tiles
    max_summons = _max_summons
    poslist = []
    select_button.text = "🔘SELECT (%d/%d)" % [len(poslist), max_summons]
    if selected_tile_gui != null:
        on_tile_select_button_toggled(selected_tile_gui.tile, true)

# signals callbacks
func on_tile_select_button_toggled(tile, pressed):
    selected_tile = tile
    if tile in tiles:
        if not selected_tile.pos in poslist:
            select_button.text = "🔘SELECT (%d/%d)" % [len(poslist), max_summons]
            select_button.disabled = not (pressed and len(poslist)<max_summons)
        else:
            select_button.text = "🔘UNSELECT (%d/%d)" % [len(poslist), max_summons]
            select_button.disabled = not pressed
    else:
        select_button.text = "🔘SELECT (%d/%d)" % [len(poslist), max_summons]
        select_button.disabled = true

func _on_SelectButton_pressed():
    if not selected_tile.pos in poslist:
        poslist.append(selected_tile.pos)
        select_button.text = "🔘UNSELECT (%d/%d)" % [len(poslist), max_summons]
    else:
        poslist.erase(selected_tile.pos)
        select_button.text = "🔘SELECT (%d/%d)" % [len(poslist), max_summons]

func _on_DoneButton_pressed():
    emit_signal("select_summons_done_button_pressed", poslist)
