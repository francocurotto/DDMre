@tool
extends TextureRect

# exports
@export_enum("DRAGON", "SPELLCASTER", "UNDEAD", "BEAST", "WARRIOR", "ITEM") 
var type : String = "DRAGON" :
    set(_type):
        type = _type
        self_modulate = COLORS[type]

@export_range(1, 4) var level = 3 :
    set(_level):
        level = _level
        $Level.text = str(level)

# constants
const COLORS = {
    "DRAGON"      : Color(1.0,0.2,0.2),
    "SPELLCASTER" : Color(0.8,0.8,0.8),
    "UNDEAD"      : Color(1.0,1.0,0.2),
    "BEAST"       : Color(0.2,1.0,0.2),
    "WARRIOR"     : Color(0.2,0.2,1.0),
    "ITEM"        : Color(0.3,0.3,0.3)}

# signals callbacks
func _on_resized():
    var min_size = min(size.y, size.x)
    $Level.add_theme_font_size_override("font_size", min_size/4)
    $Level.add_theme_constant_override("outline_size", min_size/8)

func _on_button_button_down():
    print("button down")

func _on_button_button_up():
    print("button up")
