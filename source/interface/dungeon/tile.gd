tool
extends MarginContainer

const MODDICT = {1 : Color(0.5,1.0,1.0,1.0), 2 : Color(1.0,0.75,0.75,1.0)}

export (String, "EMPTY", "BLOCK", "PATH") var tile_type = "EMPTY" setget set_tile_type
export (int, 1, 2) var player_tile = 1 setget set_player_tile
export (String, "NONE", "MONSTER_LORD", "DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", 
    "ITEM") var dungobj_type = "NONE" setget set_dungobj_type
export (int, 1, 2) var player_dungobj = 1 setget set_player_dungobj

var tile

signal mouse_entered_dungobj(dungobj)
signal mouse_exited_dungobj

func set_tile(_tile):
    tile = _tile
    update_tile()

func update_tile():
    # case not path
    if not tile.is_path():
        set_tile_bare(tile.NAME)
    # case path
    else:
        set_tile_bare(tile.NAME, tile.player.id)
        # case no content (TODO: modify for vortex?)
        if tile.content.is_none():
            set_dungobj(tile.content.NAME)
        # case content
        else:
            set_dungobj(tile.content.NAME, tile.content.player.id)

func set_tile_bare(_tile_type, _player_tile=null):
    var icon = "TILE_" + _tile_type
    if _tile_type == "PATH":
        icon += "_P" + str(_player_tile)
    $TileRect.texture = load("res://art/icons/" + icon + ".png")

func set_dungobj(_dungobj_type, _dungobj_player=null):
    # case no content
    if _dungobj_type == "NONE":
        $DungobjRect.texture = null
        return
    # case content
    var icon = _dungobj_type
    if icon in Globals.TYPES + ["ITEM"]:
        icon = "TYPE_" + icon
    $DungobjRect.texture = load("res://art/icons/" + icon + ".png")
    $DungobjRect.modulate = MODDICT[_dungobj_player]

func _on_DungobjRect_mouse_entered():
    if tile.is_path():
        emit_signal("mouse_entered_dungobj", tile.content)

func _on_DungobjRect_mouse_exited():
    emit_signal("mouse_exited_dungobj")

func set_tile_type(_tile_type):
    tile_type = _tile_type
    set_tile_bare(tile_type, player_tile)

func set_player_tile(_player_tile):
    player_tile = _player_tile
    set_tile_bare(tile_type, player_tile)

func set_dungobj_type(_dungobj_type):
    dungobj_type = _dungobj_type
    set_dungobj(dungobj_type, player_dungobj)
    
func set_player_dungobj(_player_dungobj):
    player_dungobj = _player_dungobj
    set_dungobj(dungobj_type, player_dungobj)
