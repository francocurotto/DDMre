@tool
extends Control

@export_enum("X1", "X2", "T1", "T2", "Z1", "Z2", "M1", "M2", "S1", "S2", "L1")
var net : String = "X1" :
    set(_net):
        net = _net
        display_net(NETDICT[net])

@export var net_rotation : int = 0 :
    set(_net_rotation):
        net_rotation = _net_rotation
        var tween = create_tween()
        tween.tween_property($Grid, "rotation", net_rotation*PI/2, 0.5)\
        .set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)

@export_enum("DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", "ITEM")
var summon_type : String = "DRAGON" :
    set(_summon_type):
        summon_type = _summon_type
        $SummonIcon.texture = load("res://assets/icons/SUMMON_%s.svg" % summon_type)

# constants
const FREQ = 0.3
const DRAG_THRESHOLD = deg_to_rad(90)
const NETDICT = {
    "X1" : [4, 6, 7,  8, 10, 13], 
    "X2" : [4, 6, 7, 10, 11, 13],
    "T1" : [3, 4, 5,  7, 10, 13],
    "T2" : [3, 4, 7,  8, 10, 13],
    "Z1" : [3, 4, 7, 10, 13, 14],
    "Z2" : [3, 4, 7, 10, 11, 13],
    "M1" : [3, 4, 7, 10, 11, 14],
    "M2" : [3, 6, 7, 10 ,11, 14],
    "S1" : [3, 6, 7,  8, 10, 13],
    "S2" : [3, 6, 7, 10, 11, 13],
    "L1" : [1, 4, 7,  8, 11, 14]
}
const NetCreator = preload("res://engine/states/net_creator.gd")

# variable
var time = 0
var rotation_pos = false
var selection_pos = false

# onready variables
@onready var center_tile = $Grid/DimensionTile8

func _ready():
    for dim_tile in $Grid.get_children():
        dim_tile.pressed.connect(on_dim_tile_pressed)
        dim_tile.dragged.connect(on_dim_tile_dragged)

func _process(delta):
        time += delta
        var alpha = abs(sin(2*PI*FREQ*time))/2 + 0.1
        %Grid.modulate = Color(1,1,1,alpha)

# public functions
func get_net():
    return NetCreator.create_net(net, Vector2i(0,0), [])

# signals callbacks
func on_dim_tile_pressed(dim_tile, press_pos):
    if dim_tile == center_tile:
        rotation_pos = null
        selection_pos = press_pos
    else:
        rotation_pos = press_pos
        selection_pos = null
        
func on_dim_tile_dragged(drag_pos):
    if rotation_pos:
        on_rotation_drag(drag_pos)
    elif selection_pos:
        on_selection_drag(drag_pos)

# private functions
func display_net(net_indeces):
    for i in %Grid.get_child_count():
        %Grid.get_child(i).display = i in net_indeces

func on_rotation_drag(drag_pos):
    var net_center = $SummonIcon.global_position
    $DrawHelp.draw_rotation(rotation_pos, drag_pos)
    var base_rotation_pos = rotation_pos - net_center
    var base_drag_pos = drag_pos - net_center
    if base_rotation_pos.angle_to(base_drag_pos) > DRAG_THRESHOLD:
        net_rotation += 1
        rotation_pos = drag_pos
    elif base_rotation_pos.angle_to(base_drag_pos) < -DRAG_THRESHOLD:
        net_rotation -= 1
        rotation_pos = drag_pos

func on_selection_drag(_drag_pos):
    pass
