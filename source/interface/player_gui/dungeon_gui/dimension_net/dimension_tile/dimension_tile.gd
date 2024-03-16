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
