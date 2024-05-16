@tool
extends AspectRatioContainer

#region signals
signal select_button_pressed
#endregion

#region preloads
const TILE_SELECTOR = preload("res://assets/icons/TILE_SELECTOR.svg")
#endregion

#region export variables
@export_enum("OPEN", "BLOCK", "NEUTRAL", "PLAYER") 
var tile_type : String = "OPEN" :
    set(_tile_type):
        tile_type = _tile_type
        set_tile_icon()

@export_range(1, 2) var tile_player = 1 :
    set(_tile_player):
        tile_player = _tile_player
        set_tile_icon()

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

@export var disabled : bool = false :
    set(_disabled):
        disabled = _disabled
        $SelectButton.disabled = disabled
#endregion

#region variables
var tile
var unfold_pivots = {
    Vector2i(1, 0) : Vector2(0,0),
    Vector2i(0,-1) : Vector2(0,0),
    Vector2i(-1,0) : size,
    Vector2i(0, 1) : size}
#endregion

#region onready variables
@onready var path_tile = $PathTile
@onready var select_button = $SelectButton
#endregion

#region public functions
func setup(_tile):
    tile = _tile
    tile_type = tile.TYPE
    tile_player = tile.player_id
    dungobj_type = tile.content.TYPE
    dungobj_player = tile.content.player_id

func tween_dim_appear(tween, _tile):
    setup(_tile)
    tween.tween_property(%DungobjIcon, "modulate", Color(0,0,0,0), 0)
    tween.tween_property($PathTile, "modulate", Color(1,1,1,1), 0.5)

func tween_dim_fold(tween, _tile, unfold):
    setup(_tile)
    var init_scale = Vector2(abs(unfold.y), abs(unfold.x))
    $PathTile.pivot_offset = unfold_pivots[unfold]
    tween.tween_property($PathTile, "modulate", Color(1,1,1,1), 0)
    tween.tween_property($PathTile, "scale", Vector2(1,1), 0.5)\
        .from(init_scale).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
    tween.parallel().tween_property($PathTile, "modulate", Color(1,1,1), 0.5)\
        .from(Color(0.2,0.2,0.2)).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)

func tween_dim_summon_appear(tween):
    tween.tween_property(%DungobjIcon, "modulate", Color(1,1,1,1), 0.5)
#endregion

#region signals callbacks
func _on_select_button_toggled(_toggled_on):
    select_button_pressed.emit(self)
    print($SelectButton.disabled)
#endregion

#region private functions
func set_tile_icon():
    $PathTile.visible = true
    if tile_type == "OPEN":
        $PathTile.visible = false
        $SelectButton.texture_pressed = null
    elif tile_type in ["BLOCK", "NEUTRAL"]:
        $PathTile.texture = load("res://assets/icons/TILE_%s.svg" % tile_type)
        $SelectButton.texture_pressed = TILE_SELECTOR
    elif tile_player in [1,2]:
        var tile_name = "TILE_PLAYER_P%d" % tile_player
        $PathTile.texture = load("res://assets/icons/%s.svg" % tile_name)
        $SelectButton.texture_pressed = TILE_SELECTOR

func set_dungobj_icon():
    if dungobj_type == "NONE":
        %DungobjIcon.texture = null
    elif dungobj_type == "MONSTER_LORD":
        %DungobjIcon.texture = load("res://assets/icons/MONSTER_LORD.svg")
    elif dungobj_player in [1,2]:
        var dungobj_icon = "SUMMON_%s_P%d" % [dungobj_type, dungobj_player]
        %DungobjIcon.texture = load("res://assets/icons/%s.svg" % dungobj_icon)
#endregion
