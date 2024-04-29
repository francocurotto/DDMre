extends Control

#region variables
var rotation_pos
var drag_pos
#endregion

#region builtin functions
func _draw():
    if rotation_pos and drag_pos:
        draw_line(Vector2(), rotation_pos, Color.RED, 4)
        draw_line(rotation_pos, drag_pos, Color.BLUE, 4)
#endregion

#region public functions
func draw_rotation(_rotation_pos, _drag_pos):
    rotation_pos = _rotation_pos - global_position
    drag_pos = _drag_pos - global_position
    queue_redraw()

func clear_draw():
    rotation_pos = null
    drag_pos = null
    queue_redraw()
#endregion

