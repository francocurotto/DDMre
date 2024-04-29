@tool
extends Node2D

#region singals
signal net_changed
#endregion

#region constants
const FREQ = 0.3
const ROTATION_THRESHOLD = deg_to_rad(45)
const SELECTION_LENGTH = 30
const NETDICT = {
    "X1"  : [4, 6, 7,  8, 10, 13], 
    "T1"  : [3, 4, 5,  7, 10, 13],
    "Z1"  : [3, 4, 7, 10, 13, 14],
    "Z1F" : [4, 5, 7, 10, 12, 13],
    "X2"  : [4, 6, 7, 10, 11, 13],
    "X2F" : [4, 7, 8,  9, 10, 13],
    "T2"  : [3, 4, 7,  8, 10, 13],
    "T2F" : [4, 5, 6,  7, 10, 13],
    "Z2"  : [3, 4, 7, 10, 11, 13],
    "Z2F" : [4, 5, 7,  9, 10, 13],
    "M1"  : [3, 4, 7, 10, 11, 14],
    "M1F" : [4, 5, 7,  9, 10, 12],
    "M2"  : [3, 6, 7, 10 ,11, 14],
    "M2F" : [5, 7, 8,  9 ,10, 12],
    "S1"  : [3, 6, 7,  8, 10, 13],
    "S1F" : [5, 6, 7,  8, 10, 13],
    "S2"  : [3, 6, 7, 10, 11, 13],
    "S2F" : [5, 7, 8,  9, 10, 13],
    "L1"  : [1, 4, 7,  8, 11, 14],
    "L1F" : [1, 4, 6,  7,  9, 12]}
#endregion

#region preload variables
const NetCreator = preload("res://engine/dungeon/nets/net_creator.gd")
#endregion

#region export variables
@export_enum("X1", "X2", "X2F", "T1", "T2", "T2F", "Z1", "Z1F", "Z2", "Z2F", "M1", "M1F", "M2", 
    "M2F", "S1", "S1F", "S2", "S2F", "L1", "L1F")
var net : String = "X1" :
    set(_net):
        net = _net
        display_net(NETDICT[net])
        net_changed.emit()

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
#endregion

#region variables
var time = 0
var rotation_pos = false
var selection_pos = false
var net_index = 0
#endregion

#region builtin functions
func _process(delta):
    time += delta
    var alpha = abs(sin(2*PI*FREQ*time))/2 + 0.1
    %Grid.modulate = Color(1,1,1,alpha)

func _input(event):
    if event is InputEventScreenTouch:
        if event.pressed:
            on_net_pressed(event.position)
        else:
            on_net_released()
    elif event is InputEventScreenDrag:
        on_net_dragged(event)
#endregion

#region public functions
func get_net():
    var trans = get_trans_list()
    return NetCreator.create_net(net.substr(0,2), Vector2i(0,0), trans)

func get_net_name():
    return net.substr(0,2)

func get_trans_list():
    var trans = []
    # add flip if necessary
    if len(net) == 3:
        trans.append("FLR")
    # add rotations
    for i in range(abs(net_rotation)):
        if net_rotation > 0:
            trans.append("TCW")
        else:
            trans.append("TAW") 
    return trans
#endregion

#region signals callbacks
func on_net_pressed(press_pos):
    var center_rect = Rect2(global_position, $Grid/DimensionTile1.size)
    if center_rect.has_point(press_pos):
        rotation_pos = null
        selection_pos = press_pos
        $NetChangeHelpers.visible = true
    # get rect for rotate from parent (dungeon gui)
    elif get_parent().get_global_rect().has_point(press_pos):
        rotation_pos = press_pos
        selection_pos = null
        $RotationHelpers.visible = true

func on_net_released():
    rotation_pos = null
    selection_pos = null
    $DrawHelp.clear_draw()
    $RotationHelpers.visible = false
    $NetChangeHelpers.visible = false
        
func on_net_dragged(event):
    if rotation_pos:
        on_rotation_drag(event.position)
    elif selection_pos:
        on_selection_drag(event)
#endregion

#region private functions
func display_net(net_indeces):
    for i in %Grid.get_child_count():
        %Grid.get_child(i).display = i in net_indeces

func on_rotation_drag(drag_pos):
    $DrawHelp.draw_rotation(rotation_pos, drag_pos)
    var net_center = $SummonIcon.global_position
    var base_rotation_pos = rotation_pos - net_center
    var base_drag_pos = drag_pos - net_center
    if base_rotation_pos.angle_to(base_drag_pos) > ROTATION_THRESHOLD:
        net_rotation += 1
        rotation_pos = drag_pos
    elif base_rotation_pos.angle_to(base_drag_pos) < -ROTATION_THRESHOLD:
        net_rotation -= 1
        rotation_pos = drag_pos

func on_selection_drag(event):
    var pos1 = int(event.position.x/SELECTION_LENGTH)
    var pos2 = int((event.position.x-event.relative.x)/SELECTION_LENGTH)
    var index = (NETDICT.keys().find(net) + (pos1-pos2)) % NETDICT.size()
    net = NETDICT.keys()[index]
#endregion
