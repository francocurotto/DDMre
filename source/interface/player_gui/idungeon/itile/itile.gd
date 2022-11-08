tool
extends MarginContainer

# export variables
export (String, "EMPTY", "BLOCK", "PATH") var tile_type = "EMPTY" setget set_tile_type
export (int, 1, 2) var player_tile = 1 setget set_player_tile
export (String, "NONE", "MONSTER_LORD", "DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR",
    "ITEM") var dungobj_type = "NONE" setget set_dungobj_type
export (int, 1, 2) var player_dungobj = 1 setget set_player_dungobj

# constants
const shader_p1 = preload("res://shaders/dungobj_P1_shader.tres")
const shader_p2 = preload("res://shaders/dungobj_P2_shader.tres")
const SHADERDICT = {0:null, 1:shader_p1, 2:shader_p2}

# variables
var tile

# signals
signal mouse_entered_summon(summon)
signal mouse_exited_tile
signal monster_pressed(tile)
signal mouse_entered_dim(pos)
signal mouse_exited_dim(pos)
signal dim_button_pressed(tile)
signal reachable_path_pressed(tile)
signal attack_button_pressed(tile)
signal mouse_entered_attack_button(content)

# setget functions
func set_tile(_tile):
    tile = _tile
    update_tile()

func update_tile():
    set_tile_icon(tile.NAME, tile.playerid)
    set_dungobj_icon(tile.content.NAME, tile.content.playerid)

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

func set_move_tile():
    $HighlightRect.visible = true
    $MoveButton.visible = true

func set_attack_tile():
    $HighlightRect.visible = true
    $AttackButton.visible = true

func set_dim_button():
    $DimButton.visible = true

func set_highlight():
    $HighlightRect.visible = true

func unset_highlight():
    $HighlightRect.visible = false

func unset_all_mods():
    $MoveButton.visible = false
    $AttackButton.visible = false
    $DimButton.visible = false
    $HighlightRect.visible = false

func enable_tile_button():
    $TileButton.disabled = false

func disable_tile_button():
    $TileButton.disabled = true

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

# signals callback
func _on_TileButton_mouse_entered():
    if tile.content.is_summon():
        emit_signal("mouse_entered_summon", tile.content)

func _on_TileButton_mouse_exited():
    emit_signal("mouse_exited_tile")

func _on_TileButton_pressed():
    if tile.content.is_monster():
        emit_signal("monster_pressed", tile)

func _on_DimButton_mouse_entered():
    _on_TileButton_mouse_entered()
    emit_signal("mouse_entered_dim", tile.pos)

func _on_DimButton_mouse_exited():
    _on_TileButton_mouse_exited()
    emit_signal("mouse_exited_dim")

func _on_DimButton_pressed():
    emit_signal("dim_button_pressed", tile)

func _on_MoveButton_pressed():
    emit_signal("reachable_path_pressed", tile)

func _on_MoveButton_mouse_entered():
    _on_TileButton_mouse_entered()

func _on_MoveButton_mouse_exited():
    _on_TileButton_mouse_exited()

func _on_AttackButton_pressed():
    _on_TileButton_mouse_exited()
    emit_signal("attack_button_pressed", tile)

func _on_AttackButton_mouse_entered():
    emit_signal("mouse_entered_attack_button", tile.content)

func _on_AttackButton_mouse_exited():
    _on_TileButton_mouse_exited()
