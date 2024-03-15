@tool
extends MarginContainer

# export variables
@export var display : bool = true:
    set(_display):
        display = _display
        if display:
            $Icon.texture = load("res://assets/icons/TILE_HIGHLIGHT.svg")
        else:
            $Icon.texture = null

# signals
signal button_down

# signals callbacks
func _on_button_button_down():
    var pressed_pos = get_viewport().get_mouse_position()
    button_down.emit(self, pressed_pos)
