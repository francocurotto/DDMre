tool
extends MarginContainer

# export variables
export (String, "EMPTY", "BLOCK", "PATH") var tile_type = "EMPTY" setget set_tile_type
export (int, 1, 2) var player_tile = 1 setget set_player_tile
export (String, "NONE", "MONSTER_LORD", "DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", 
    "ITEM") var dungobj_type = "NONE" setget set_dungobj_type
export (int, 1, 2) var player_dungobj = 1 setget set_player_dungobj

# constants
const MODDICT = {1 : Color(0.5,1.0,1.0,1.0), 2 : Color(1.0,0.75,0.75,1.0)}
const SELECTMOD = Color(1.0,1.0,0.5,1.0)

# variables
var tile

# signals
signal mouse_entered_summon(summon)
signal mouse_entered_attacked(attacked) #TODO: remove unused signal
signal mouse_exited_summon
signal monster_pressed(tile)
signal reachable_path_pressed(tile)
signal monster_lord_pressed(tile)

# setget functions
func set_tile(_tile):
    tile = _tile
    update_tile()

func update_tile():
    set_tile_icon(tile.NAME, tile.playerid)
    set_dungobj_icon(tile.content.NAME, tile.content.playerid)

func set_tile_icon(_tile_type, _player_tile=null):
    var icon = "TILE_" + _tile_type
    if _tile_type == "PATH": # case path
        icon += "_P" + str(_player_tile)
    $TileRect.texture = load("res://art/icons/" + icon + ".png")

func set_dungobj_icon(_dungobj_type, _dungobj_player=null):
    if _dungobj_type == "NONE": # case no content
        $DungobjRect.texture = null
    else: # case content
        var icon = _dungobj_type
        if _dungobj_type in Globals.TYPES + ["ITEM"]: # case summon
            icon = "TYPE_" + _dungobj_type
        $DungobjRect.texture = load("res://art/icons/" + icon + ".png")
        $DungobjRect.modulate = MODDICT[_dungobj_player]

func set_selectmod():
    $DungobjRect.modulate = SELECTMOD

func unset_selectmod():
    if not tile.content.is_none():
        $DungobjRect.modulate = MODDICT[tile.content.player.id]

func set_movetile():
    $MoveRect.visible = true

func unset_movetile():
    $MoveRect.visible = false

func set_attacktile():
    $AttackRect.visible = true

func unset_attacktile():
    $AttackRect.visible = false

func enable_button():
    $TileButton.disabled = false

func disable_button():
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
    emit_signal("mouse_exited_summon")

func _on_TileButton_pressed():
    # case monster pressed
    if tile.content.is_monster():
        emit_signal("monster_pressed", self)
    # case reachable path is pressed
    elif  tile.is_reachable():
        emit_signal("reachable_path_pressed", self)
    # case reachable path is pressed
    elif tile.content.is_monster_lord():
        emit_signal("monster_lord_pressed", self)
