tool
extends MarginContainer

const MODDICT = {1 : Color(0.8,1.0,1.0,1), 2 : Color(1.0,0.9,0.9,1.0)}

export (String, "EMPTY", "BLOCK", "PATH") var tile_type = "EMPTY" setget set_tile_type
export (int, 1, 2) var player_tile = 1 setget set_player_tile
export (String, "NONE", "MONSTER_LORD", "DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", 
    "ITEM") var dungobj_type = "EMPTY" setget set_dungobj_type
export (int, 1, 2) var player_dungobj = 1 setget set_player_dungobj

func set_tile(tile):
    set_tile_bare(tile.NAME, tile.get("player_id"))
    if "content" in tile:
        set_dungobj(tile.content.NAME, tile.content.get("player_id"))

func set_tile_bare(_tile_type, _player_tile):
    var icon = "TILE_" + _tile_type
    if _tile_type == "PATH":
        icon += "_P" + str(_player_tile)
    $TileRect.texture = load("res://art/icons/" + icon + ".png")

func set_dungobj(_dungobj_type, _dungobj_player):
    if _dungobj_type == "NONE" or _dungobj_type == null:
        $DungobjRect.texture = null
        return
    var icon = _dungobj_type
    if icon in ["DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", "ITEM"]:
        icon = "TYPE_" + icon
    $DungobjRect.texture = load("res://art/icons/" + icon + ".png")
    $DungobjRect.modulate = MODDICT[_dungobj_player]

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
