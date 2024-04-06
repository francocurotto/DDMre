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

@export var disabled : bool = true :
    set(_disabled):
        disabled = _disabled
        $PathTile.disabled = disabled

func set_tile_icon():
    $PathTile.visible = true
    if tile_type == "OPEN":
        $PathTile.visible = false
    elif tile_type in ["BLOCK", "NEUTRAL"]:
        $PathTile.texture_normal = load("res://assets/icons/TILE_%s.svg" % tile_type)
    elif tile_player in [1,2]:
        var tile_name = "TILE_PLAYER_P%d" % tile_player
        $PathTile.texture_normal = load("res://assets/icons/%s.svg" % tile_name)

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
    elif dungobj_player in [1,2]:
        var dungobj_icon = "SUMMON_%s_P%d" % [dungobj_type, dungobj_player]
        %DungobjIcon.texture = load("res://assets/icons/%s.svg" % dungobj_icon)

# variables
var tile
var unfold_pivots = {
    Vector2i(1, 0) : Vector2(0,0),
    Vector2i(0,-1) : Vector2(0,0),
    Vector2i(-1,0) : size,
    Vector2i(0, 1) : size}

# onready variables
@onready var path_tile = $PathTile
@onready var dim_button = $DimButton

# signals
signal select_button_toggled
signal dim_button_toggled

# public functions
func setup(_tile):
    tile = _tile
    tile_type = tile.TYPE
    tile_player = tile.player_id
    dungobj_type = tile.content.TYPE
    dungobj_player = tile.content.player_id

func tween_dim_appear(tween, _tile):
    setup(_tile)
    tween.tween_property($PathTile, "modulate", Color(1,1,1,1), 0.5)

func tween_dim_fold(tween, _tile, unfold):
    var init_scale = Vector2(abs(unfold.y), abs(unfold.x))
    $PathTile.pivot_offset = unfold_pivots[unfold]
    setup(_tile)
    tween.tween_property($PathTile, "modulate", Color(1,1,1,1), 0)
    tween.tween_property($PathTile, "scale", Vector2(1,1), 0.4)\
    .from(init_scale).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

# signals callbacks
func _on_path_tile_toggled(toggled_on):
    select_button_toggled.emit(self, toggled_on)

func _on_dim_button_toggled(toggled_on):
    dim_button_toggled.emit(self, toggled_on)
    # press path tile
    path_tile.button_pressed = not path_tile.button_pressed
