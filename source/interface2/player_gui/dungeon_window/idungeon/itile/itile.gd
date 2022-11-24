tool
extends MarginContainer

# export variables
export (String, "NONE", "ML1", "ML2") var ml = "NONE" setget set_ml

# variables
var tile

# onready variables
onready var tile_frame = $TileFrame
onready var tile_button = $TileButton

# signals
signal tile_button_toggled

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
    tile_button.disabled = not tile.is_path()

func release_button():
    tile_button.set_pressed_no_signal(false)
    tile_frame.set_highlight(false)

# signals callbacks
func _on_TileButton_toggled(button_pressed):
    tile_frame.set_highlight(button_pressed)
    emit_signal("tile_button_toggled", self)
