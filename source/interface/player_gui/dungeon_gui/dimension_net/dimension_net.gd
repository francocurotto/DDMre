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
        net_changed.emit()

@export_enum("DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", "ITEM")
var summon_type : String = "DRAGON" :
    set(_summon_type):
        summon_type = _summon_type
        $SummonIcon.texture = load("res://assets/icons/SUMMON_%s.svg" % summon_type)

# constants
const FREQ = 0.3
const ROTATION_THRESHOLD = deg_to_rad(45)
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

# singals
signal net_changed

func _process(delta):
        time += delta
        var alpha = abs(sin(2*PI*FREQ*time))/2 + 0.1
        %Grid.modulate = Color(1,1,1,alpha)

# public functions
func get_net():
    var trans = []
    for i in range(abs(net_rotation)):
        if sign(net_rotation):
            trans.append("TCW")
        else:
            trans.append("TAW") 
    return NetCreator.create_net(net, Vector2i(0,0), trans)

# signals callbacks
func _input(event):
    if event is InputEventScreenTouch:
        if event.pressed:
            on_net_pressed(event.position)
        else:
            on_net_released()
    elif event is InputEventScreenDrag:
        on_net_dragged(event.position)

func on_net_pressed(press_pos):
    var center_rect = Rect2(global_position, $Grid/DimensionTile1.size)
    if center_rect.has_point(press_pos):
        rotation_pos = null
        selection_pos = press_pos
    # get rect for rotate from parent (dungeon gui)
    elif get_parent().get_global_rect().has_point(press_pos):
        rotation_pos = press_pos
        selection_pos = null

func on_net_released():
    rotation_pos = null
    selection_pos = null
    $DrawHelp.clear_draw()
        
func on_net_dragged(drag_pos):
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
    if base_rotation_pos.angle_to(base_drag_pos) > ROTATION_THRESHOLD:
        net_rotation += 1
        rotation_pos = drag_pos
    elif base_rotation_pos.angle_to(base_drag_pos) < -ROTATION_THRESHOLD:
        net_rotation -= 1
        rotation_pos = drag_pos

func on_selection_drag(_drag_pos):
    pass
