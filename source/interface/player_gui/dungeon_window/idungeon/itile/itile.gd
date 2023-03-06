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
onready var tile_jump_button = $TileJumpButton
onready var tile_dim_button = $TileDimButton
onready var tile_reply_ability_button = $TileReplyAbilityButton

# signals
signal tile_select_button_toggled(itile, pressed)
signal tile_move_button_pressed(itile)
signal tile_attack_button_pressed(itile)
signal tile_jump_button_pressed(itile)
signal tile_dim_button_pressed(itile)

# setget functions
func set_tile(_tile):
    tile = _tile
    tile_frame.set_tile_icon(tile.NAME, tile.playerid, tile.vortex)
    tile_frame.set_dungobj_icon(tile.content.NAME, tile.content.playerid)

func set_ml(_ml):
    ml = _ml
    if ml == "NONE":
        $TileFrame.set_tile_icon("EMPTY", 0, false)
        $TileFrame.set_dungobj_icon("NONE", 0)
    elif ml == "ML1":
        $TileFrame.set_tile_icon("PATH", 1, false)
        $TileFrame.set_dungobj_icon("MONSTER_LORD", 1)
    elif ml == "ML2":
        $TileFrame.set_tile_icon("PATH", 2, false)
        $TileFrame.set_dungobj_icon("MONSTER_LORD", 2)

func set_highlight():
    tile_frame.highlight = true

func unset_highlight():
    tile_frame.highlight = false

func unset_summon_highlight():
    tile_frame.summon_highlight_type = "NONE"

# public functions
func enable_select_button():
    tile_select_button.visible = tile.is_path()
    tile_select_button.set_pressed_no_signal(false)

func release_select_button():
    tile_select_button.set_pressed_no_signal(false)
    unset_highlight()

func enable_move_button():
    tile_move_button.visible = true

func enable_attack_button():
    tile_attack_button.visible = true
    set_highlight()

func enable_jump_button():
    tile_jump_button.visible = true
    set_highlight()

func enable_dim_button():
    tile_dim_button.visible = true

func enable_reply_ability_button():
    tile_reply_ability_button.visible = true

func disable_all_buttons():
    tile_select_button.visible = false
    tile_move_button.visible = false
    tile_attack_button.visible = false
    tile_jump_button.visible = false
    tile_dim_button.visible = false

func disable_all_highlights():
    unset_highlight()
    unset_summon_highlight()

# signals callbacks
func _on_TileSelectButton_toggled(button_pressed):
    tile_frame.highlight = button_pressed
    emit_signal("tile_select_button_toggled", self, button_pressed)

func _on_TileMoveButton_pressed():
    emit_signal("tile_move_button_pressed", self)

func _on_TileAttackButton_pressed():
    emit_signal("tile_attack_button_pressed", self)

func _on_TileJumpButton_pressed():
    emit_signal("tile_jump_button_pressed", self)

func _on_TileDimButton_pressed():
    emit_signal("tile_dim_button_pressed", self)

func _on_TileReplyAbilityButton_pressed():
    print("tile reply ability button pressed")
