@tool
extends TextureRect

# export variables
@export var display : bool = true:
    set(_display):
        display = _display
        if display:
            texture = load("res://assets/icons/TILE_HIGHLIGHT.svg")
        else:
            texture = null

# signals
signal pressed

# signals callbacks
func _input(event):
    var rect = Rect2(global_position, size)
    # check event type
    if event is InputEventScreenTouch and event.pressed:
        # check event inside dice
        if rect.has_point(event.position):
            pressed.emit(self, event.position)
