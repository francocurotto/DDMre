tool
extends MarginContainer

# export variables
export (String, "EMPTY", "BLOCK", "PATH") var tile_type = "EMPTY" setget set_tile_type
export (int, 0, 2) var tile_player = 1 setget set_tile_player
export (String, "NONE", "MONSTER_LORD", "DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR",
    "ITEM") var dungobj_type = "NONE" setget set_dungobj_type
export (int, 1, 2) var dungobj_player = 1 setget set_dungobj_player
export (bool) var vortex = false setget set_vortex
export (bool) var highlight = false setget set_highlight
export (bool) var attack_highlight = false setget set_attack_highlight
export (bool) var ability_highlight = false setget set_ability_highlight
export (bool) var ability_select_highlight = false setget set_ability_select_highlight
export (String, "NONE", "DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", "ITEM") \
    var summon_highlight_type = "NONE" setget set_summon_highlight_type

# variables
var tile

# onready variables
onready var tile_select_button = $TileButtons/TileSelectButton
onready var tile_move_button = $TileButtons/TileMoveButton
onready var tile_attack_button = $TileButtons/TileAttackButton
onready var tile_jump_button = $TileButtons/TileJumpButton
onready var tile_dim_button = $TileButtons/TileDimButton

# signals
signal tile_select_button_toggled(tile_gui, pressed)
signal tile_move_button_pressed(tile_gui)
signal tile_attack_button_pressed(tile_gui)
signal tile_jump_button_pressed(tile_gui)
signal tile_dim_button_pressed(tile_gui)

# setget functions
func set_tile(_tile):
    tile = _tile
    set_tile_icon(tile.TYPE, tile.playerid, tile.vortex)
    set_dungobj_icon(tile.content.NAME, tile.content.playerid)

func set_tile_icon(_tile_type, _tile_player, _vortex):
    tile_type = _tile_type
    tile_player = _tile_player
    var icon = "TILE_" + tile_type
    if _tile_type == "PLAYER": # case player path
        icon += "_P" + str(tile_player)
    $TileRects/TileRect.texture = load("res://art/icons/" + icon + ".png")
    set_vortex(_vortex)

func set_dungobj_icon(_dungobj_type, _dungobj_player):
    dungobj_type = _dungobj_type
    dungobj_player = _dungobj_player
    if _dungobj_type == "NONE": # case no content
        $DungobjRects/DungobjRect.texture = null
    else: # case content
        var icon = dungobj_type
        if _dungobj_type in Globals.SUMMONTYPES: # case summon
            icon = "TYPE_" + dungobj_type + "_P" + str(dungobj_player)
        $DungobjRects/DungobjRect.texture = load("res://art/icons/" + icon + ".png")

func set_tile_type(_tile_type):
    set_tile_icon(_tile_type, tile_player, vortex)

func set_tile_player(_tile_player):
    set_tile_icon(tile_type, _tile_player, vortex)

func set_dungobj_type(_dungobj_type):
    set_dungobj_icon(_dungobj_type, dungobj_player)

func set_dungobj_player(_dungobj_player):
    set_dungobj_icon(dungobj_type, _dungobj_player)

func set_highlight(_highlight):
    highlight = _highlight
    $TileRects/HighlightRect.visible = highlight

func set_attack_highlight(_attack_highlight):
    attack_highlight = _attack_highlight
    $TileRects/AttackHighlightRect.visible = attack_highlight

func set_ability_highlight(_ability_highlight):
    ability_highlight = _ability_highlight
    $TileRects/AbilityHighlightRect.visible = ability_highlight

func set_ability_select_highlight(_ability_select_highlight):
    ability_select_highlight = _ability_select_highlight
    $TileRects/AbilitySelectHighlightRect.visible = ability_select_highlight

func set_summon_highlight_type(_summon_highlight_type):
    summon_highlight_type = _summon_highlight_type
    if summon_highlight_type == "NONE": # case no content
        $DungobjRects/SummonHighlightRect.texture = null
    else: # case content
        $DungobjRects/SummonHighlightRect.texture = load("res://art/icons/TYPE_" + summon_highlight_type + ".png")

func set_vortex(_vortex):
    vortex = _vortex
    $DungobjRects/VortexRect.visible = vortex

# public functions
func enable_select_button():
    tile_select_button.visible = tile.is_path() or tile.is_block()

func release_select_button():
    set_highlight(false)
    tile_select_button.set_pressed_no_signal(false)

func enable_move_button():
    tile_move_button.visible = true

func enable_attack_button():
    tile_attack_button.visible = true

func enable_jump_button():
    tile_jump_button.visible = true

func enable_dim_button():
    tile_dim_button.visible = true

func disable_all_buttons():
    tile_select_button.visible = false
    tile_move_button.visible = false
    tile_attack_button.visible = false
    tile_jump_button.visible = false
    tile_dim_button.visible = false

func disable_all_highlights():
    set_highlight(false)
    set_attack_highlight(false)
    set_ability_highlight(false)
    set_ability_select_highlight(false)
    set_summon_highlight_type("NONE")

# signals callbacks
func _on_TileSelectButton_toggled(button_pressed):
    set_highlight(button_pressed)
    emit_signal("tile_select_button_toggled", self, button_pressed)

func _on_TileMoveButton_pressed():
    emit_signal("tile_move_button_pressed", self)

func _on_TileAttackButton_pressed():
    emit_signal("tile_attack_button_pressed", self)

func _on_TileJumpButton_pressed():
    emit_signal("tile_jump_button_pressed", self)

func _on_TileDimButton_pressed():
    emit_signal("tile_dim_button_pressed", self)
