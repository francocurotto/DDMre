tool
extends MarginContainer

# export variables
export (String, "EMPTY", "BLOCK", "PATH") var tile_type = "EMPTY" setget set_tile_type
export (int, 1, 2) var tile_player = 1 setget set_tile_player
export (String, "NONE", "MONSTER_LORD", "DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR",
    "ITEM") var dungobj_type = "NONE" setget set_dungobj_type
export (int, 1, 2) var dungobj_player = 1 setget set_dungobj_player
export (bool) var highlight = false setget set_highlight
export (String, "NONE", "DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", "ITEM") \
    var summon_highlight_type = "NONE" setget set_summon_highlight_type

# constants
const shader_p1 = preload("res://shaders/dungobj_P1_shader.tres")
const shader_p2 = preload("res://shaders/dungobj_P2_shader.tres")
const SHADERDICT = {0:null, 1:shader_p1, 2:shader_p2}

# variables
var tile

# setget functions
func set_tile_icon(_tile_type, _tile_player):
    tile_type = _tile_type
    tile_player = _tile_player
    var icon = "TILE_" + tile_type
    if _tile_type == "PATH": # case path
        icon += "_P" + str(tile_player)
    $TileRect.texture = load("res://art/icons/" + icon + ".png")

func set_dungobj_icon(_dungobj_type, _dungobj_player):
    dungobj_type = _dungobj_type
    dungobj_player = _dungobj_player
    if _dungobj_type == "NONE": # case no content
        $DungobjRect.texture = null
    else: # case content
        var icon = dungobj_type
        if _dungobj_type in Globals.TYPES + ["ITEM"]: # case summon
            icon = "TYPE_" + dungobj_type
            $DungobjRect.material = SHADERDICT[dungobj_player]
        else: # monster lord
            $DungobjRect.material = null
        $DungobjRect.texture = load("res://art/icons/" + icon + ".png")

func set_tile_type(_tile_type):
    set_tile_icon(_tile_type, tile_player)

func set_tile_player(_tile_player):
    set_tile_icon(tile_type, _tile_player)

func set_dungobj_type(_dungobj_type):
    set_dungobj_icon(_dungobj_type, dungobj_player)

func set_dungobj_player(_dungobj_player):
    set_dungobj_icon(dungobj_type, _dungobj_player)

func set_highlight(_highlight):
    highlight = _highlight
    $HighlightRect.visible = highlight

func set_summon_highlight_type(_summon_highlight_type):
    summon_highlight_type = _summon_highlight_type
    if summon_highlight_type == "NONE": # case no content
        $SummonHighlightRect.texture = null
    else: # case content
        $SummonHighlightRect.texture = load("res://art/icons/TYPE_" + summon_highlight_type + ".png")