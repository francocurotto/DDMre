@tool
extends AspectRatioContainer

# export variables
@export_enum("OPEN", "BLOCK", "NEUTRAL", "PLAYER") 
var tile_type : String = "OPEN" :
    set(_tile_type):
        tile_type = _tile_type
        set_tile_icon()

@export_range(1, 2) var tile_player = 1 :
    set(_tile_player):
        tile_player = _tile_player
        set_tile_icon()

func set_tile_icon():
    if tile_type == "PLAYER":
        var tile_name = "TILE_PLAYER_P%d" % tile_player
        $TileIcon.texture_normal = load("res://assets/icons/%s.svg" % tile_name)
    else:
        $TileIcon.texture_normal = load("res://assets/icons/TILE_%s.svg" % tile_type)
    # disable if tile is open
    $TileIcon.disabled = tile_type == "OPEN"

@export_enum("NONE", "DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", 
    "ITEM", "MONSTER_LORD")
var dungobj_type : String = "NONE" :
    set(_dungobj_type):
        dungobj_type = _dungobj_type
        set_dungobj_icon()

@export_range(1, 2) var dungobj_player = 1 :
    set(_dungobj_player):
        dungobj_player = _dungobj_player
        set_dungobj_icon()

func set_dungobj_icon():
    if dungobj_type == "NONE":
        %DungobjIcon.texture = null
    elif dungobj_type == "MONSTER_LORD":
        %DungobjIcon.texture = load("res://assets/icons/MONSTER_LORD.svg")
    else:
        var dungobj_icon = "SUMMON_%s_P%d" % [dungobj_type, dungobj_player]
        %DungobjIcon.texture = load("res://assets/icons/%s.svg" % dungobj_icon)

# variables
var tile

# onready variables
@onready var tile_icon = $TileIcon

# signals
signal select_button_toggled

# public functions
func setup(_tile):
    tile = _tile
    tile_type = tile.TYPE
    tile_player = tile.playerid
    dungobj_type = tile.content.TYPE
    dungobj_player = tile.content.playerid


func _on_tile_icon_toggled(toggled_on):
    select_button_toggled.emit(self, toggled_on)
