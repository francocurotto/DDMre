tool
extends MarginContainer

# export variables
export (String, "NONE", "ML1", "ML2") var ml = "NONE" setget set_ml

# variables
var tile

# onready variables
onready var tile_frame = $TileFrame
onready var tile_select_button = $TileSelectButton
onready var tile_move_button = $TileMoveButton
onready var tile_attack_button = $TileAttackButton
onready var tile_dim_button = $TileDimButton

# signals
signal tile_select_button_toggled(itile, pressed)
signal tile_dim_button_pressed(itile)

# setget functions
func set_tile(_tile):
    tile = _tile
    update_tile()

func set_ml(_ml):
    ml = _ml
    if ml == "NONE":
        $TileFrame.set_tile_icon("EMPTY", 0)
        $TileFrame.set_dungobj_icon("NONE", 0)
    elif ml == "ML1":
        $TileFrame.set_tile_icon("PATH", 1)
        $TileFrame.set_dungobj_icon("MONSTER_LORD", 1)
    elif ml == "ML2":
        $TileFrame.set_tile_icon("PATH", 2)
        $TileFrame.set_dungobj_icon("MONSTER_LORD", 2)

# public functions
func update_tile():
    tile_frame.set_tile_icon(tile.NAME, tile.playerid)
    tile_frame.set_dungobj_icon(tile.content.NAME, tile.content.playerid)
    enable_select_button()

func enable_select_button():
    tile_select_button.visible = tile.is_path()
    tile_select_button.set_pressed_no_signal(false)

func release_select_button():
    tile_select_button.set_pressed_no_signal(false)
    tile_frame.highlight = false

func enable_move_button():
    tile_move_button.visible = true
    tile_frame.highlight = true

func enable_attack_button():
    tile_attack_button.visible = true
    tile_frame.highlight = true

func enable_dim_button():
    tile_dim_button.visible = true

func disable_all_buttons():
    tile_select_button.visible = false
    tile_move_button.visible = false
    tile_attack_button.visible = false
    tile_dim_button.visible = false
    tile_frame.highlight = false

# signals callbacks
func _on_TileSelectButton_toggled(button_pressed):
    tile_frame.set_highlight(button_pressed)
    emit_signal("tile_select_button_toggled", self, button_pressed)

func _on_TileMoveButton_pressed():
    print("tile move button")

func _on_TileAttackButton_pressed():
    print("tile attack button")

func _on_TileDimButton_pressed():
    emit_signal("tile_dim_button_pressed", self)

