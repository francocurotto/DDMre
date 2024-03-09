extends Control

var net_center
var rotation_pos
var drag_pos

func draw_rotation(_net_center, _rotation_pos, _drag_pos):
    net_center = _net_center
    rotation_pos = _rotation_pos
    drag_pos = _drag_pos
    queue_redraw()

func _draw():
    if net_center and rotation_pos and drag_pos:
        draw_line(net_center, rotation_pos, Color.RED, 4)
        draw_line(rotation_pos, drag_pos, Color.BLUE, 4)
