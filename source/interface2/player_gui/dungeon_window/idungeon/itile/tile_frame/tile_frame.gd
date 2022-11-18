tool
extends MarginContainer

# export variables
export (String, "EMPTY", "BLOCK", "PATH") var tile_type = "EMPTY" setget set_tile_type
export (int, 1, 2) var player_tile = 1 setget set_player_tile
export (String, "NONE", "MONSTER_LORD", "DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR",
    "ITEM") var dungobj_type = "NONE" setget set_dungobj_type
export (int, 1, 2) var player_dungobj = 1 setget set_player_dungobj
export (bool) var highlight = false setget set_highlight

# constants
const shader_p1 = preload("res://shaders/dungobj_P1_shader.tres")
const shader_p2 = preload("res://shaders/dungobj_P2_shader.tres")
const SHADERDICT = {0:null, 1:shader_p1, 2:shader_p2}

# variables
var tile

# setget functions
func set_tile_icon(_tile_type, _player_tile):
    var icon = "TILE_" + _tile_type
    if _tile_type == "PATH": # case path
        icon += "_P" + str(_player_tile)
    $TileRect.texture = load("res://art/icons/" + icon + ".png")

func set_dungobj_icon(_dungobj_type, _dungobj_player):
    if _dungobj_type == "NONE": # case no content
        $DungobjRect.texture = null
    else: # case content
        var icon = _dungobj_type
        if _dungobj_type in Globals.TYPES + ["ITEM"]: # case summon
            icon = "TYPE_" + _dungobj_type
            $DungobjRect.material = SHADERDICT[_dungobj_player]
        else: # monster lord
            $DungobjRect.material = null
        $DungobjRect.texture = load("res://art/icons/" + icon + ".png")

func set_tile_type(_tile_type):
    tile_type = _tile_type
    set_tile_icon(tile_type, player_tile)

func set_player_tile(_player_tile):
    player_tile = _player_tile
    set_tile_icon(tile_type, player_tile)

func set_dungobj_type(_dungobj_type):
    dungobj_type = _dungobj_type
    set_dungobj_icon(dungobj_type, player_dungobj)

func set_player_dungobj(_player_dungobj):
    player_dungobj = _player_dungobj
    set_dungobj_icon(dungobj_type, player_dungobj)

func set_highlight(_highlight):
    highlight = _highlight
    $HighlightRect.visible = highlight
