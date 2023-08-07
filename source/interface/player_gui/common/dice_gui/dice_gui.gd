@tool
extends TextureRect

# exports
@export_enum("DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", "ITEM") 
var type : String = "DRAGON" :
    set(_type):
        type = _type
        self_modulate = COLORS[type]

# constants
const COLORS = {
    "DRAGON"      : Color(1,0,0),
    "SPELLCASTER" : Color(1,1,1),
    "UNDEAD"      : Color(1,1,0),
    "BEAST"       : Color(0,1,0),
    "WARRIOR"     : Color(0,0,1),
    "ITEM"        : Color(0,0,0)}

# signals callbacks
func _on_resized():
    var min_size = min(size.y, size.x)
    $Level.add_theme_font_size_override("font_size", min_size/4)
    $Level.add_theme_constant_override("outline_size", min_size/8)
