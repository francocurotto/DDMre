@tool
extends TextureRect

#region preloads
const tile_highlight = preload("res://assets/icons/TILE_HIGHLIGHT.svg")
const tile_rotation = preload("res://assets/icons/TILE_ROTATION.svg")
#endregion

#region export variables
@export var display : bool = true :
    set(_display):
        display = _display
        if display:
            modulate = Color(1,1,1,1)
        else:
            modulate = Color(1,1,1,0)

@export var rotation_mode : bool = false :
    set(_rotation_mode):
        rotation_mode = _rotation_mode
        texture = tile_rotation if rotation_mode else tile_highlight
#endregion
